rules = {}
counts = Hash.new(0)
steps = 40
lines = File.readlines("14/input.txt", chomp: true)

lines[2..-1].each do |line|
  k, v = line.split(" -> ")

  rules[k] = {
    becomes: [k[0] + v, v + k[1]],
    counts: [lines[0].scan(k).count] + [0] * steps
  }
end

steps.times do |i|
  rules.each do |_, rule|
    rule[:becomes].each { |n| rules[n][:counts][i + 1] += rule[:counts][i] }
  end
end

rules.each { |k, v| counts[k[0]] += v[:counts][-1] }
counts[lines[0][-1]] += 1

p counts.values.max - counts.values.min
