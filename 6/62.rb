input = File.read("6/6.txt")
feesh = (0..9).map { |i| input.count(i.to_s) }

256.times do
  feesh[8] = feesh.shift
  feesh[6] += feesh[8]
end

p feesh.sum
