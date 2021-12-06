pos = [0, 0]
dirs = { "up" => [0, -1], "down" => [0, 1], "forward" => [1, 0] }

File.foreach("2/2.txt") do |line|
  dir, dist = line.split(" ")
  velo = dirs[dir].map { |d| d * dist.to_i }
  pos = pos.each_with_index.map { |c, i| c + velo[i] }
end

p pos[0] * pos[1]
