require "set"
require "./lib/grid"

map = Grid.new
distances = { [0, 0] => 0 }
visited = Set.new

File.foreach("15/input.txt", chomp: true) { |l| map << l.chars.map(&:to_i) }

dest = [map.max_x, map.max_y]

until visited.include?(dest)
  coords, dist =
    distances.select { |k, _| !visited.include?(k) }.min_by { |_, v| v }

  map.each_neighbor(*coords, diags: false) do |nxy, nv|
    newdist = dist + nv
    distances[nxy] = [distances[nxy] || Float::INFINITY, newdist].min
  end

  visited << coords
end

p distances[dest]
