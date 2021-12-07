@burns = { 0 => 0, 1 => 1 }

def burn(dist)
  @burns[dist] ||= burn(dist - 1) + dist
end

🦀 = File.read("7/7.txt").split(",").map(&:to_i)
average = 🦀.sum / 🦀.count
p 🦀.sum { |c| burn((c - average).abs) }
