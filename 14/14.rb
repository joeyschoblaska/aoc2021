chain = ""
rules = {}
counts = Hash.new(0)
steps = 40

File.foreach("14/input.txt", chomp: true) do |line|
  case line
  when /\w{4}/
    chain = line
  when /\w\w -> \w/
    k, v = line.split(" -> ")
    rules[k] = { char: v }
  end
end

rules.each do |k, v|
  rules[k][:counts] = Array.new(steps + 1, 0)
  rules[k][:counts][0] = chain.scan(k).count
  rules[k][:creates] =
    "#{k[0]}#{v[:char]}#{k[1]}"
      .chars
      .each_cons(2)
      .map { |pair| rules.key?(pair.join) ? pair.join : nil }
      .compact
end

steps.times do |i|
  rules.each do |k, v|
    v[:creates].each { |c| rules[c][:counts][i + 1] += v[:counts][i] }
  end
end

rules.each { |k, v| counts[k[0]] += v[:counts][-1] }

counts[chain[-1]] += 1
counts = counts.to_a.sort_by { |k, v| v }
p counts[-1][1] - counts[0][1]
