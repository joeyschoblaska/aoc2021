class Grid
  include Enumerable

  def initialize(rows = [])
    @rows = rows
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
    return "[]" if @rows.empty?
    (0..max_y)
      .map { |y| (0..max_x).map { |x| self[x, y].inspect }.join(", ") }
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

  def each_neighbor(x, y, diags: true)
    [
      diags && x > 0 && y > 0 ? [x - 1, y - 1] : nil,
      y > 0 ? [x, y - 1] : nil,
      diags && x < max_x && y > 0 ? [x + 1, y - 1] : nil,
      x > 0 ? [x - 1, y] : nil,
      x < max_x ? [x + 1, y] : nil,
      diags && x > 0 && y < max_y ? [x - 1, y + 1] : nil,
      y < max_y ? [x, y + 1] : nil,
      diags && x < max_x && y < max_y ? [x + 1, y + 1] : nil
    ].compact.each { |x, y| yield [[x, y], self[x, y]] }
  end

  def neighbors(x, y, diags: true)
    enum_for(:each_neighbor, x, y, diags: diags)
  end

  def values
    enum_for(:each).map { |_, v| v }
  end

  def max_x
    @rows.map { |r| r&.count || 0 }.max - 1
  end

  def max_y
    @rows.count - 1
  end
end
