require "./lib/grid"

grid = Grid.new
low_points = []

File.foreach("9/9.txt", chomp: true).map { |r| grid << r.chars.map(&:to_i) }

grid.each do |(x, y), v|
  low_points << v if grid.neighbors(x, y, diags: false).all? { |_, nv| nv > v }
end

p low_points.sum { |p| p + 1 }
