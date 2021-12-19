require_relative "scanner"
require "set"

scanners = []

File
  .foreach("19/input.txt", chomp: true)
  .each do |line|
    if line =~ /scanner/
      scanners << Scanner.new
    elsif line =~ /,/
      scanners[-1] << line.split(",").map(&:to_i)
    end
  end

known = scanners[0]
unknown = scanners[1..-1]

coords = Set.new(known.beacons.map { |b| [b.x, b.y, b.z] })

while unknown.any?
  testing = unknown.rotate![0]

  if testing.fit_to(coords)
    coords += testing.beacons.map { |b| [b.x, b.y, b.z] }
    unknown.shift
    puts "#{unknown.count} unlocated scanners remaining"
  end
end

puts "found #{coords.count} unique beacons"

max_dist = 0

scanners.each do |scanner|
  others = scanners - [scanner]
  others.each { |other| max_dist = [max_dist, scanner.dist_from(other)].max }
end

puts "max distance between scanners: #{max_dist}"
