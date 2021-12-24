model = [0] * 14
instructions = File.readlines("24/input.txt", chomp: true)

def execute(instructions, numbers)
  w, x, y, z = 0, 0, 0, 0

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

model = 99_999_999_999_999 + 1

loop do
  model -= 1
  numbers = model.to_s.chars.map(&:to_i)
  next if numbers.any?(&:zero?)
  result = execute(instructions, numbers)
  p model
  break if result[3] == 0
end
