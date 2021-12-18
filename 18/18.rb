require_relative "string"
require "json"

lines = File.readlines("18/input.txt", chomp: true)

def reduce(lines)
  lines.reduce(nil) do |acc, line|
    acc.nil? ? line : [JSON.parse(acc), JSON.parse(line)].to_json.reduce!
  end
end

def magnitude(pair)
  return pair if pair.is_a?(Integer)
  return magnitude(JSON.parse(pair)) if pair.is_a?(String)
  3 * magnitude(pair[0]) + 2 * magnitude(pair[1])
end

# part 1
reduced = reduce(lines)
p reduced
p magnitude(reduced)

# part 2
max = 0

lines.each do |left|
  (lines - [left]).each do |right|
    reduced = reduce([left, right])
    max = [max, magnitude(reduced)].max
  end
end

p max
