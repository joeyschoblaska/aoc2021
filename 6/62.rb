feesh = Array.new(9, 0)

File.read("6/6.txt").split(",").each { |f| feesh[f.to_i] += 1 }

256.times do
  feesh[8] = feesh.shift
  feesh[6] += feesh[8]
end

p feesh.sum
