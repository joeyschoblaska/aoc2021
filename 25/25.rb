require "./lib/grid"

grid = Grid.new
steps = 0

File.foreach("25/input.txt", chomp: true) do |l|
  grid << l.chars.map { |c| c == "." ? nil : c }
end

def print_grid(grid)
  grid.each_row { |row| puts row.map { |c| c || "." }.join }
end

loop do
  stable = true

  east = Grid.new
  south = Grid.new

  grid.each do |(x, y), _|
    east[x, y] = nil
    south[x, y] = nil
  end

  grid.each do |(x, y), v|
    if v == ">"
      x2 = x == grid.max_x ? 0 : x + 1

      if grid[x2, y].nil?
        east[x2, y] = v
        stable = false
      else
        east[x, y] = v
      end
    elsif v == "v"
      east[x, y] = v
    end
  end

  east.each do |(x, y), v|
    if v == "v"
      y2 = y == grid.max_y ? 0 : y + 1

      if east[x, y2].nil?
        south[x, y2] = v
        stable = false
      else
        south[x, y] = v
      end
    elsif v == ">"
      south[x, y] = v
    end
  end

  break if stable

  steps += 1
  grid = south
end

p steps + 1
