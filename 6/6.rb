feesh = Hash.new(0)

File.read("6/6.txt").split(",").each { |f| feesh[f.to_i] += 1 }

256.times do
  feesh =
    feesh.each_with_object(Hash.new(0)) do |(k, v), h|
      if k == 0
        h[6] += v
        h[8] += v
      else
        h[k - 1] += v
      end
    end
end

p feesh.values.sum
