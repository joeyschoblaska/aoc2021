input = File.read("6/6.txt")
feesh = (0..8).map { |i| input.count(i.to_s) }
256.times { feesh.rotate! && feesh[6] += feesh[8] }

p feesh.sum
