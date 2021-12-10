coords = Hash.new(0)

File.foreach("5.txt", chomp: true) do |line|
  x1, y1, x2, y2 = line.scan(/\d+/).map(&:to_i)
  loc = [x1, y1]
  dir = [(x2 - x1).clamp(-1, 1), (y2 - y1).clamp(-1, 1)]

  loop do
    coords[loc] += 1
    break if loc == [x2, y2]
    loc = [loc[0] + dir[0], loc[1] + dir[1]]
  end
end

p coords.values.select { |v| v > 1 }.count
