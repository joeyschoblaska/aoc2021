require "set"
require "pry"
require "json"

cache = {}
instruction_sets = []

File.foreach("24/input.txt", chomp: true) do |line|
  line =~ /inp/ ? instruction_sets << [line] : instruction_sets[-1] << line
end

def execute(instructions, numbers, w = 0, x = 0, y = 0, z = 0)
  instructions.each do |instruction|
    command, a, b = instruction.split(/\s/)

    case command
    when "inp"
      eval "#{a} = #{numbers.shift}"
    when "add"
      eval "#{a} = #{a} + #{b}"
    when "mul"
      eval "#{a} = #{a} * #{b}"
    when "div"
      eval "#{a} = #{a} / #{b}"
    when "mod"
      eval "#{a} = #{a} % #{b}"
    when "eql"
      "#{a} = #{a} == #{b} ? 1 : 0"
    end
  end

  [w, x, y, z]
end

candidates = {}

if File.exists?("24/candidates.json")
  candidates = JSON.parse(File.read("24/candidates.json"))
else
  (0..13).to_a.reverse.each do |i|
    candidates[i] = []

    ztargets =
      i == 13 ? Set.new([0]) : Set.new(candidates[i + 1].map { |c| c[1] })

    (1..9).each do |n|
      p [i, n]
      (0..1_000_000).each do |zin|
        result = execute(instruction_sets[i], [n], 0, 0, 0, zin)
        zout = result[3]
        candidates[i] << [n, zin, zout] if ztargets.include?(zout)
      end
    end

    raise "no candidates found" if candidates[i].empty?
  end

  File.open("24/candidates.json", "w") { |f| f.puts candidates.to_json }
end

binding.pry
