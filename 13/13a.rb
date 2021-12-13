paper = []
folds = []

File.foreach("13/input.txt", chomp: true) do |line|
  if line =~ /\d+,\d+/
    x, y = line.split(",").map(&:to_i)
    paper[x] ||= []
    paper[x][y] = 1
  elsif line =~ /fold/
    dir, loc = line[/[xy]=\d+/].split("=")
    folds << [dir, loc.to_i]
  end
end

[folds[0]].each do |folddir, foldloc|
  folded = []

  paper.each_with_index do |col, x|
    next unless col

    col.each_with_index do |e, y|
      next if folddir == "x" && x == foldloc
      next if folddir == "y" && y == foldloc

      if folddir == "x" && x > foldloc
        folded[foldloc - (x - foldloc)] ||= []
        folded[foldloc - (x - foldloc)][y] ||= e
      elsif folddir == "y" && y > foldloc
        folded[x] ||= []
        folded[x][foldloc - (y - foldloc)] ||= e
      else
        folded[x] ||= []
        folded[x][y] = e
      end
    end
  end

  paper = folded
end

p paper.flatten.compact.count
