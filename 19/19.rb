require "set"

class Scanner
  FACES = %i[zpos zneg ypos yneg xpos xneg]

  attr_reader :beacons, :pos

  def initialize
    @beacons = []
    @up = :zpos # which face is pointed up?
    @rot = 0 # number of 90-degree rotations along axis of upward face
    @pos = [0, 0, 0] # position of the scanner
  end

  def <<(coords)
    @beacons << Beacon.new(coords)
  end

  def rotate!
    if @rot == 3
      @rot = 0
      @up = FACES[(FACES.index(@up) + 1) % FACES.count]
    else
      @rot += 1
    end
  end

  def position!(x, y, z)
    @pos = [x, y, z]
  end

  def to_s
    "up: #{@up}, rot: #{@rot}\n" +
      beacons.map { |b| "#{b.x},#{b.y},#{b.z}\n" }.join
  end

  def fit_to(coords)
    24.times do
      rotate!
      position!(0, 0, 0)
      scan_beacons

      initial_beacon_coords = beacons.map { |b| [b.x, b.y, b.z] }

      initial_beacon_coords.each do |bx, by, bz|
        coords.each do |cx, cy, cz|
          position!(cx - bx, cy - by, cz - bz)
          scan_beacons
          matching = beacons.select { |b| coords.include?([b.x, b.y, b.z]) }
          return true if matching.count >= 12
        end
      end
    end

    return false
  end

  def dist_from(other)
    x, y, z = @pos
    xo, yo, zo = other.pos
    (x - xo).abs + (y - yo).abs + (z - zo).abs
  end

  private

  def scan_beacons
    @beacons.each { |b| b.scan(@up, @rot, @pos) }
  end
end

class Beacon
  attr_accessor :x, :y, :z

  def initialize(coords)
    @x0, @y0, @z0 = coords
    @x, @y, @z = coords
  end

  def scan(up, rot, pos)
    x, y, z = @x0, @y0, @z0

    orientations =
      case up
      when :zpos
        [[x, y, z], [y, -x, z], [-x, -y, z], [-y, +x, z]]
      when :zneg
        [[x, -y, -z], [-y, -x, -z], [-x, y, -z], [y, x, -z]]
      when :ypos
        [[x, -z, y], [-z, -x, y], [-x, z, y], [z, x, y]]
      when :yneg
        [[x, z, -y], [z, -x, -y], [-x, -z, -y], [-z, x, -y]]
      when :xpos
        [[y, z, x], [z, -y, x], [-y, -z, x], [-z, y, x]]
      when :xneg
        [[z, y, -x], [y, -z, -x], [-z, -y, -x], [-y, z, -x]]
      end

    @x, @y, @z = orientations[rot].each_with_index.map { |c, i| c + pos[i] }
  end
end

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
