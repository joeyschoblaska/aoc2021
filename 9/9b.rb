require "./lib/grid"

grid = Grid.new
basins = []

File.foreach("9/9.txt", chomp: true).map { |r| grid << r.chars.map(&:to_i) }

grid.each do |(x, y), v|
  next if v == 9
  next if basins.any? { |b| b.include? [x, y] }

  to_check = [[x, y]]
  checked = []

  until to_check.empty?
    checking = to_check.pop

    grid.each_neighbor(*checking, diags: false) do |(nx, ny), nv|
      next if nv == 9
      next if checked.include?([nx, ny])
      next if to_check.include?([nx, ny])
      to_check << [nx, ny]
    end

    checked << checking
  end

  basins << checked
end

p basins.map(&:count).sort.last(3).inject(:*)
