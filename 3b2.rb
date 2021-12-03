def binfind(lines:, ifequal:, maxby:, cur: 0)
  return lines[0] if lines.count == 1

  groups = lines.group_by { |l| l[cur] }.to_h

  binfind(
    ifequal: ifequal,
    maxby: maxby,
    cur: cur + 1,
    lines:
      if groups.values[0]&.count == groups.values[1]&.count
        groups[ifequal]
      else
        groups.values.max_by(&maxby)
      end
  )
end

lines = File.readlines("3.txt", chomp: true)
o2gen = binfind(lines: lines, ifequal: "1", maxby: ->(n) { n.count })
co2scrub = binfind(lines: lines, ifequal: "0", maxby: ->(n) { -n.count })

p o2gen.to_i(2) * co2scrub.to_i(2)
