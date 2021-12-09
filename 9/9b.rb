require "pry"

def neighbors(r, c, rows)
  [
    r > 0 ? [r - 1, c] : nil,
    r < rows.length - 1 ? [r + 1, c] : nil,
    c > 0 ? [r, c - 1] : nil,
    c < rows[r].length - 1 ? [r, c + 1] : nil
  ].compact
end

rows =
  File.readlines("9/9.txt", chomp: true).map { |r| r.split(//).map(&:to_i) }

basins = []

rows.each_with_index do |row, r|
  row.each_with_index do |e, c|
    next if basins.any? { |b| b.include? [r, c] }
    next if e == 9

    to_check = [[r, c]]
    checked = []

    until to_check.empty?
      checking = to_check.pop

      neighbors(checking[0], checking[1], rows).each do |n|
        next if rows[n[0]][n[1]] == 9
        next if checked.include?(n)
        next if to_check.include?(n)
        to_check << n
      end

      checked << checking
    end

    basins << checked
  end
end

p basins.map(&:count).sort.last(3).inject(:*)
