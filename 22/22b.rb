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
  new_cuboids = [
    Cuboid.new(
      (xrange.first..xrange.last + 1), # +1 to account for the fact that the ranges
      (yrange.first..yrange.last + 1), # don't describe the bounds of the box itself,
      (zrange.first..zrange.last + 1) #  but the centers of the cubes the box contains
    )
  ]

  intersects, cuboids = cuboids.partition { |c| c.intersects?(new_cuboids[0]) }

  intersects =
    intersects.map do |intersect|
      if onoff == :on
        new_cuboids = new_cuboids.map { |c| c.subtract(intersect) }.flatten
        intersect
      else
        intersect.subtract(new_cuboids[0])
      end
    end.flatten

  cuboids += new_cuboids if onoff == :on
  cuboids += intersects
end

p cuboids.sum(&:volume)
