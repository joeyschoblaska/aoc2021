counts = nil

File.foreach("3.txt", chomp: true) do |line|
  bits = line.split(//).map(&:to_i)
  counts ||= Array.new(bits.count, 0)
  bits.each_with_index { |b, i| counts[i] += b == 1 ? 1 : -1 }
end

gamma = counts.map { |c| c > 0 ? "1" : "0" }.join
epsilon = counts.map { |c| c > 0 ? "0" : "1" }.join

p gamma.to_i(2) * epsilon.to_i(2)
