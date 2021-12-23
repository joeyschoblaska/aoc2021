class Cuboid
  attr_accessor :xrange, :yrange, :zrange

  def initialize(xrange, yrange, zrange)
    @xrange, @yrange, @zrange = xrange, yrange, zrange
  end

  def intersects?(other)
    paired_ranges(other).all? do |s, o|
      (s.first > o.first && s.first < o.last) ||
        (s.last > o.first && s.last < o.last) ||
        (o.first > s.first && o.first < s.last) ||
        (o.last > s.first && o.last < s.last) || o.cover?(s) || s.cover?(o)
    end
  end

  def subtract(other)
    return [self] unless intersects?(other)

    xs, ys, zs =
      paired_ranges(other).map do |s, o|
        if s.first < o.first && o.last < s.last
          [(s.first..o.first), o, (o.last..s.last)]
        elsif s.first < o.first && s.last > o.first
          [(s.first..o.first), (o.first..s.last)]
        elsif s.first < o.last && s.last > o.last
          [(s.first..o.last), (o.last..s.last)]
        else
          [s]
        end
      end

    xs
      .map { |x| ys.map { |y| zs.map { |z| Cuboid.new(x, y, z) } } }
      .flatten
      .select { |c| !c.intersects?(other) }
  end

  def volume
    (@xrange.size - 1) * (@yrange.size - 1) * (@zrange.size - 1)
  end

  private

  def paired_ranges(other)
    [[@xrange, other.xrange], [@yrange, other.yrange], [@zrange, other.zrange]]
  end
end
