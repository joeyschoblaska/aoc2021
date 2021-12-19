require_relative "beacon"

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

  def scan_beacons
    @beacons.each { |b| b.scan(@up, @rot, @pos) }
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

  def to_s
    "up: #{@up}, rot: #{@rot}\n" +
      beacons.map { |b| "#{b.x},#{b.y},#{b.z}\n" }.join
  end
end
