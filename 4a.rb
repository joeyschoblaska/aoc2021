class Board
  def initialize(rows)
    @rows = rows.map { |r| r.split(/\s+/).map(&:to_i) }
    @hits = Array.new(5) { Array.new(5, false) }
    @last_called = nil
  end

  def call(num)
    (0..4).each do |r|
      (0..4).each { |c| @hits[r][c] = true if @rows[r][c] == num }
    end

    @last_called = num
  end

  def won?
    (0..4).any? { |r| @hits[r].all? || (0..4).all? { |c| @hits[r][c] } }
  end

  def score
    (0..4).map { |r| (0..4).map { |c| @hits[r][c] ? 0 : @rows[r][c] }.sum }
      .sum * @last_called
  end
end

nums = []
boards = []

File.open("4.txt") do |file|
  nums = file.gets.split(",").map(&:to_i)
  rows = []

  while line = file.gets&.strip
    next if line.length == 0

    if (rows << line).count == 5
      boards << Board.new(rows)
      rows = []
    end
  end
end

nums.each do |num|
  boards.each { |b| b.call(num) }

  if winner = boards.find(&:won?)
    p winner.score
    break
  end
end
