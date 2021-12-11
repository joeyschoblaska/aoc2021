@octos = {}

File
  .readlines("11/input.txt", chomp: true)
  .each_with_index do |row, y|
    row.chars.each_with_index { |c, x| @octos[[x, y]] = c.to_i }
  end

def neighbors(x, y)
  [x - 1, x, x + 1].map { |xx| [y - 1, y, y + 1].map { |yy| [xx, yy] } }
    .flatten(1)
    .select { |xy| @octos[xy] && xy != [x, y] }
end

def flash(x, y)
  @octos[[x, y]] += 1

  neighbors(x, y).each do |xy|
    @octos[xy] += 1 unless @octos[xy] == 10
    flash(*xy) if @octos[xy] == 10
  end
end

1.step do |i|
  @octos.each { |k, v| @octos[k] += 1 }
  @octos.each { |k, v| flash(*k) if v == 10 }

  if @octos.select { |k, v| v > 9 }.count == 100
    puts "everybody flash your hands! #{i.to_s}"
    break
  end

  @octos.each { |k, v| @octos[k] = 0 if v > 9 }
end
