require_relative "string"

@exits = Hash.new([])
@paths = []

File.foreach("12/input.txt", chomp: true) do |line|
  a, b = line.split("-")
  @exits[a] += [b]
  @exits[b] += [a]
end

def visited_small_cave_twice?(path)
  path.uniq.any? { |p| p.small? && path.count(p) == 2 }
end

def spelunk(cave, path = [])
  path = path + [cave]

  if cave == "start"
    @exits[cave].each { |c| spelunk(c, path) }
  elsif cave == "end"
    @paths << path
  else
    @exits[cave].each do |c|
      next if c == "start"
      next if c.small? && path.include?(c) && visited_small_cave_twice?(path)

      spelunk(c, path)
    end
  end
end

spelunk("start")

p @paths.count
