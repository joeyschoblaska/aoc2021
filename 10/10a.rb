points = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25_137 }
brackets = ["(", ")", "{", "}", "<", ">", "[", "]"]
score = 0

File.foreach("10/10.txt", chomp: true) do |line|
  stack = []
  line
    .split(//)
    .each do |ch|
      if brackets.index(ch) % 2 == 0
        stack << ch
      elsif brackets[brackets.index(ch) - 1] == stack.last
        stack.pop
      else
        puts "#{line} - Expected #{brackets[brackets.index(stack.last) + 1]}, got #{ch}"
        score += points[ch]
        break
      end
    end
end

p score
