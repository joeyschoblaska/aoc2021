require_relative "board"
require_relative "parse_input"

nums, boards = parse_input("4/4.txt")

nums.each do |num|
  boards.each { |b| b.call(num) }

  if winner = boards.find(&:won?)
    p winner.score
    break
  end
end
