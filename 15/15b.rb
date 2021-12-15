# https://en.wikipedia.org/wiki/A*_search_algorithm#Pseudocode

require "set"
require "./lib/grid"

def inc(line, i)
  line.map { |n| (n + i) > 9 ? (n + i) % 9 : (n + i) }
end

lines = File.readlines("15/input.txt").map { |l| l.strip.chars.map(&:to_i) }
lines = lines.map { |line| 5.times.map { |i| inc(line, i) }.flatten }
lines += 4.times.map { |i| lines.map { |line| inc(line, i + 1) } }.flatten(1)

map = Grid.new(lines)

# dist of a naive path to dest
def naive_dist(x, y, map, dest)
  dist = 0

  until [x, y] == dest
    x += 1 and dist += map[x, y] if x < dest[0]
    y += 1 and dist += map[x, y] if y < dest[1]
  end

  dist
end

def calc_dist(came_from, map)
  dist = 0
  node = [map.max_x, map.max_y]

  while node != [0, 0]
    dist += map[*node]
    node = came_from[node]
  end

  dist
end

open = Set.new([[0, 0]])
came_from = {}
dest = [map.max_x, map.max_y]

# the cost of the cheapest actual path from start to k currently known
found = { [0, 0] => 0 }

# the current best guess of dist of shortest path from start to dest through k
guesses = { [0, 0] => naive_dist(0, 0, map, dest) }

while open.any?
  current = open.min_by { |o| found[o] }

  break if current == dest

  open.delete(current)

  map.each_neighbor(*current, diags: false) do |nxy, nv|
    tentative_found = found[current] + nv

    if found[nxy].nil? || tentative_found < found[nxy]
      came_from[nxy] = current
      found[nxy] = tentative_found
      guesses[nxy] = tentative_found + naive_dist(*nxy, map, dest)
      open << nxy
    end
  end
end

p calc_dist(came_from, map)
