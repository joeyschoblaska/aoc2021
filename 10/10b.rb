require_relative "array"

points = { ")" => 1, "]" => 2, "}" => 3, ">" => 4 }
brackets = "(){}<>[]".split(//)
scores = []

File.foreach("10/10.txt", chomp: true) do |line|
  stack = []
  score = 0
  error = false

  line
    .split(//)
    .each do |ch|
      if brackets.index(ch).even?
        stack << ch
      elsif brackets.before(ch) == stack.last
        stack.pop
      else
        error = true
        break
      end
    end

  next if error
  next if stack.empty?

  stack.reverse.each do |ch|
    closer = brackets.after(ch)
    score *= 5
    score += points[closer]
  end

  scores << score
end

p scores.sort[scores.count / 2]
