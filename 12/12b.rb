require_relative "string"

@exits = Hash.new([])
@paths = []

File.foreach("12/input.txt", chomp: true) do |line|
  a, b = line.split("-")
  @exits[a] += [b]
  @exits[b] += [a]
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

      doubled = path.uniq.any? { |p| p.small? && path.count(p) == 2 }

      next if c.small? && doubled && path.include?(c)

      spelunk(c, path)
    end
  end
end

spelunk("start")

p @paths.count
