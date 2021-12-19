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
