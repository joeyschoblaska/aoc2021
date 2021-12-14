chain = nil
rules = {}
counts = Hash.new(0)
steps = 40

File.foreach("14/input.txt", chomp: true) do |line|
  chain ||= line
  k, v = line.split(" -> ")
  rules[k] = { char: v } if k && v
end

rules.each do |k, v|
  v[:counts] = [chain.scan(k).count] + Array.new(steps, 0)
  v[:becomes] = [k[0] + v[:char], v[:char] + k[1]].select { |p| rules.key?(p) }
end

steps.times do |i|
  rules.each do |_, rule|
    rule[:becomes].each { |n| rules[n][:counts][i + 1] += rule[:counts][i] }
  end
end

rules.each { |k, v| counts[k[0]] += v[:counts][-1] }
counts[chain[-1]] += 1

p counts.values.max - counts.values.min
