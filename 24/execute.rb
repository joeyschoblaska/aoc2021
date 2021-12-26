@instruction_sets = []

File.foreach("24/input.txt", chomp: true) do |line|
  line =~ /inp/ ? @instruction_sets << [line] : @instruction_sets[-1] << line
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
