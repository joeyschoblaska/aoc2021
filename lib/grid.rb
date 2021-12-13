class Grid
  include Enumerable

  def initialize()
    @rows = []
  end

  def []=(x, y, val)
    @rows[y] ||= []
    @rows[y][x] = val
  end

  def <<(row)
    @rows << row
  end

  def [](x, y)
    @rows[y][x]
  rescue NoMethodError
    nil
  end

  def each
    return if @rows.empty?
    (0..max_x).each { |x| (0..max_y).each { |y| yield [[x, y], self[x, y]] } }
  end

  def inspect
    (0..max_x)
      .map { |x| (0..max_y).map { |y| self[x, y].inspect }.join(", ") }
      .join("\n")
  end

  def to_s
    inspect
  end

  def each_row
    (0..max_y).each { |y| yield (0..max_x).map { |x| self[x, y] } }
  end

  def each_col
    (0..max_x).each { |x| yield (0..max_y).map { |y| self[x, y] } }
  end

  private

  def max_x
    @rows.map { |r| r&.count || 0 }.max - 1
  end

  def max_y
    @rows.count - 1
  end
end
