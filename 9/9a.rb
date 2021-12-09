rows =
  File.readlines("9/9.txt", chomp: true).map { |r| r.split(//).map(&:to_i) }

low_points = []

rows.each_with_index do |row, r|
  row.each_with_index do |e, c|
    neighbors = [
      r > 0 ? rows[r - 1][c] : nil,
      r < rows.length - 1 ? rows[r + 1][c] : nil,
      c > 0 ? rows[r][c - 1] : nil,
      c < row.length - 1 ? rows[r][c + 1] : nil
    ].compact

    low_points << e if neighbors.compact.all? { |n| n > e }
  end
end

p low_points.sum { |p| p + 1 }
