require_relative "board"
require_relative "parse_input"

nums, boards = parse_input("4/4.txt")

nums.each do |num|
  boards.each { |b| b.call(num) }

  if boards.count == 1 && boards[0].won?
    p boards[0].score
    break
  else
    boards.select! { |b| !b.won? }
  end
end
