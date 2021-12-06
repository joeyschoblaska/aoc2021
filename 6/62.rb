input = File.read("6/6.txt")
🐟 = (0..8).map { |i| input.count(i.to_s) }
256.times { 🐟.rotate! && 🐟[6] += 🐟[8] }
p 🐟.sum
