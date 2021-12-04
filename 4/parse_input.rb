require_relative "board"

def parse_input(path)
  nums = []
  boards = []

  File.open(path) do |file|
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

  [nums, boards]
end
