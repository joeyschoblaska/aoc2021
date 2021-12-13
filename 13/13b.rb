require "./lib/grid"

paper = Grid.new
folds = []

File.foreach("13/input.txt", chomp: true) do |line|
  if line =~ /\d+,\d+/
    x, y = line.split(",").map(&:to_i)
    paper[x, y] = 1
  elsif line =~ /fold/
    dir, loc = line[/[xy]=\d+/].split("=")
    folds << [dir, loc.to_i]
  end
end

folds.each do |folddir, foldloc|
  folded = Grid.new

  paper.each do |(x, y), val|
    next if folddir == "x" && x == foldloc
    next if folddir == "y" && y == foldloc

    if folddir == "x" && x > foldloc
      folded[foldloc - (x - foldloc), y] ||= val
    elsif folddir == "y" && y > foldloc
      folded[x, foldloc - (y - foldloc)] ||= val
    else
      folded[x, y] = val
    end
  end

  paper = folded
end

paper.each_row { |row| puts row.map { |e| e ? "#" : " " }.join }
