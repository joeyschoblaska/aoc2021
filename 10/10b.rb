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
      if brackets.index(ch) % 2 == 0
        stack << ch
      elsif brackets[brackets.index(ch) - 1] == stack.last
        stack.pop
      else
        error = true
        break
      end
    end

  next if error
  next if stack.empty?

  stack.reverse.each do |ch|
    closer = brackets[brackets.index(ch) + 1]
    score *= 5
    score += points[closer]
  end

  scores << score
end

p scores.sort[scores.count / 2]
