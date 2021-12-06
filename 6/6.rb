feesh = Hash.new(0)
File.read("6/6.txt").scan(/\d+/).map(&:to_i).each { |f| feesh[f] += 1 }

256.times do |i|
  feesh =
    feesh.each_with_object(Hash.new(0)) do |kv, h|
      if kv[0] == 0
        h[6] += kv[1]
        h[8] = kv[1]
      else
        h[kv[0] - 1] += kv[1]
      end
    end
end

p feesh.values.sum
