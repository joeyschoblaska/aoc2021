require_relative "cuboid"

instructions =
  File
    .readlines("22/input.txt", chomp: true)
    .map do |line|
      onoff, ranges = line.split(/\s/)

      x, y, z =
        ranges
          .split(",")
          .map { |r| r.gsub(/\w=/, "") }
          .map { |r| Range.new(*r.split("..").map(&:to_i)) }

      [onoff.to_sym, x, y, z]
    end

cuboids = []

instructions.each do |onoff, xrange, yrange, zrange|
  cuboid = Cuboid.new(xrange, yrange, zrange)
  intersects, cuboids = cuboids.partition { |c| c.intersects?(cuboid) }

  # maybe instead of entering this loop, I need to first split the cuboid along
  # each intersection, and then resolve them as groups (intersecting cuboid and
  # fragments of cuboid)
  intersects.each do |intersect|
    # add / subtract intersects and cuboid
    # add resulting cuboids back into set
  end
end

p cuboids.sum(&:volume)
