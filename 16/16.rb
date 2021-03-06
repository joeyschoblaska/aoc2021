def parse(str, hex: false)
  str = str.chars.map { sprintf("%04b", _1.to_i(16)) }.join("") if hex
  packet = {}

  packet[:version] = str.slice!(0, 3).to_i(2)
  packet[:type_id] = str.slice!(0, 3).to_i(2)

  if packet[:type_id] == 4
    packet[:value] = parse_value(str)
    packet[:subpackets] = []
  else
    packet[:subpackets] =
      case str.slice!(0, 1)
      when "0"
        len = str.slice!(0, 15).to_i(2)
        parse_subpackets_by_len(str, len)
      when "1"
        num = str.slice!(0, 11).to_i(2)
        parse_subpackets_by_num(str, num)
      end
  end

  packet
end

def parse_value(str)
  val = ""

  loop do
    slice = str.slice!(0, 5)
    val << slice[1, 4]
    break if slice[0] == "0"
  end

  val.to_i(2)
end

def parse_subpackets_by_len(str, len)
  substr = str.slice!(0, len)
  subpackets = []
  subpackets << parse(substr) until substr.empty?
  subpackets
end

def parse_subpackets_by_num(str, num)
  num.times.map { parse(str) }
end

def vsum(subpackets: [], version:, **_)
  subpackets.empty? ? version : version + subpackets.sum { |sub| vsum(**sub) }
end

def operate(type_id:, value: nil, subpackets: [], **_)
  case type_id
  when 0
    subpackets.sum { |p| operate(**p) }
  when 1
    subpackets.reduce(1) { |acc, p| acc *= operate(**p) }
  when 2
    subpackets.map { |p| operate(**p) }.min
  when 3
    subpackets.map { |p| operate(**p) }.max
  when 4
    value
  when 5
    operate(**subpackets[0]) > operate(**subpackets[1]) ? 1 : 0
  when 6
    operate(**subpackets[0]) < operate(**subpackets[1]) ? 1 : 0
  when 7
    operate(**subpackets[0]) == operate(**subpackets[1]) ? 1 : 0
  end
end

raw = File.read("16/input.txt").strip
packet = parse(raw, hex: true)

p [:vsum, vsum(**packet)]
p [:operate, operate(**packet)]
