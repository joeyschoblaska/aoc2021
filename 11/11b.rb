require "./lib/grid"

@🐙 = Grid.new

File.foreach("11/input.txt", chomp: true) do |line|
  @🐙 << line.chars.map(&:to_i)
end

def flash(x, y)
  @🐙[x, y] = 99

  @🐙.each_neighbor(x, y) do |(nx, ny), val|
    next if val == 99
    @🐙[nx, ny] += 1
    flash(nx, ny) if val >= 9
  end
end

1.step do |i|
  @🐙.each { |(x, y), v| @🐙[x, y] += 1 }
  @🐙.each { |(x, y), v| flash(x, y) if v == 10 }

  if @🐙.values.all? { |v| v > 9 }
    puts "everybody flash your hands! #{i.to_s}"
    break
  end

  @🐙.each { |(x, y), v| @🐙[x, y] = 0 if v > 9 }
end
