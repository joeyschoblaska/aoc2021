🦀 = File.read("7/7.txt").split(",").map(&:to_i)
median = 🦀.sort[🦀.count / 2]
p 🦀.sum { |c| (c - median).abs }
