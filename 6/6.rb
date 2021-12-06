feesh = Hash.new(0)

File.read("6/6.txt").split(",").each { |f| feesh[f.to_i] += 1 }

256.times do
  feesh =
    feesh.each_with_object(Hash.new(0)) do |(days_to_breed, count), h|
      if days_to_breed == 0
        h[6] += count
        h[8] += count
      else
        h[days_to_breed - 1] += count
      end
    end
end

p feesh.values.sum
