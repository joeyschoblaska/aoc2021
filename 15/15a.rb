require "set"
require "./lib/grid"

dists = { [0, 0] => 0 }
visited = Set.new
lines = File.readlines("15/input.txt")
map = Grid.new(lines.map { |l| l.strip.chars.map(&:to_i) })
dest = [map.max_x, map.max_y]

until visited.include?(dest)
  pos, dist = dists.select { |k, _| !visited.include?(k) }.min_by { |_, v| v }

  map.each_neighbor(*pos, diags: false) do |nxy, nv|
    newdist = dist + nv
    dists[nxy] = [dists[nxy] || Float::INFINITY, newdist].min
  end

  visited << pos
end

p dists[dest]
