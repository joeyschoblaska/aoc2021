require_relative "array"

points = { ")" => 3, "]" => 57, "}" => 1197, ">" => 25_137 }
brackets = "(){}<>[]".chars
score = 0

File.foreach("10/10.txt", chomp: true) do |line|
  stack = []
  line.chars.each do |ch|
    if brackets.index(ch).even?
      stack << ch
    elsif brackets.before(ch) == stack.last
      stack.pop
    else
      puts "#{line} - Expected #{brackets.after(stack.last)}, got #{ch}"
      score += points[ch]
      break
    end
  end
end

p score
