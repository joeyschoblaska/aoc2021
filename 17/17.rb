target = { x: (139..187), y: (-148..-89) }

def max_height(vx, vy, target)
  probe = [0, 0]
  max = 0

  loop do
    probe = [probe[0] + vx, probe[1] + vy]
    vx -= 1 if vx.positive?
    vx += 1 if vx.negative?
    vy -= 1

    max = [probe[1], max].max

    break if target[:x].include?(probe[0]) && target[:y].include?(probe[1])
    return nil if probe[1] < target[:y].min
    return nil if probe[0] > target[:x].max
  end

  max
end

velos =
  1000.times.to_a.map { |x| 1000.times.map { |y| [x, y - 200] } }.flatten(1)

# part 1
puts "max height: " + velos.map { |v| max_height(*v, target) }.compact.max.to_s

# part 2
puts "hits: " + velos.select { |v| max_height(*v, target) }.count.to_s
