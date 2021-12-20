require "./lib/grid"

algorithm = []
image = Grid.new
pad = 100

File
  .foreach("20/input.txt", chomp: true)
  .with_index do |line, i|
    pad.times { image << [0] * (pad * 2 + line.length) } if i == 2

    if i == 0
      algorithm = line.chars.map { |c| c == "#" ? 1 : 0 }
    elsif i > 1
      image <<
        ([0] * pad) + line.chars.map { |c| c == "#" ? 1 : 0 } + ([0] * pad)
    end
  end

pad.times { image << [0] * (image.max_x + 1) }

50.times do |i|
  p i
  new_image = Grid.new

  image.each do |(x, y), v|
    neighbors = image.neighbors(x, y)

    vals =
      if neighbors.count == 8
        [
          image[x - 1, y - 1],
          image[x, y - 1],
          image[x + 1, y - 1],
          image[x - 1, y],
          image[x, y],
          image[x + 1, y],
          image[x - 1, y + 1],
          image[x, y + 1],
          image[x + 1, y + 1]
        ]
      else
        [v] * 9
      end

    new_image[x, y] = algorithm[vals.map(&:to_s).join.to_i(2)]
  end

  image = new_image
end

p image.values.sum
