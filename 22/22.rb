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

cuboids = {}

instructions.each do |onoff, xrange, yrange, zrange|
  next if xrange.first > 50 || xrange.first < -50
  xrange.each do |x|
    yrange.each { |y| zrange.each { |z| cuboids[[x, y, z]] = onoff == :on } }
  end
end

p cuboids.values.select { |v| v }.count
