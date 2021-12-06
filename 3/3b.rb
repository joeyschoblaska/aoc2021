def binfind(path:, ifequal:, maxby:)
  cur = 0
  lines = File.readlines(path, chomp: true)

  while lines.count > 1
    counts = Hash.new(0)
    lines.each { |line| counts[line[cur]] += 1 }
    keep = counts.values.uniq.count == 1 ? ifequal : counts.max_by(&maxby)[0]
    lines.select! { |line| line[cur] == keep }
    cur += 1
  end

  lines[0]
end

o2gen = binfind(path: "3/3.txt", ifequal: "1", maxby: ->(n) { n[1] })
co2scrub = binfind(path: "3/3.txt", ifequal: "0", maxby: ->(n) { -n[1] })

p o2gen.to_i(2) * co2scrub.to_i(2)
