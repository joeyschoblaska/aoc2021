def binfind(lines:, f:, cur: 0)
  return lines[0] if lines.count == 1
  ones, zeroes = lines.partition { |l| l[cur] == "1" }
  binfind(f: f, cur: cur + 1, lines: f.call(ones, zeroes))
end

lines = File.readlines("3.txt", chomp: true)

o2gen = binfind(lines: lines, f: ->(o, z) { o&.count >= z&.count ? o : z })
co2scrub = binfind(lines: lines, f: ->(o, z) { o&.count < z&.count ? o : z })

p o2gen.to_i(2) * co2scrub.to_i(2)
