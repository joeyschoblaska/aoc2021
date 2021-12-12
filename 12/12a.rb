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
    @exits[cave].each { |c| spelunk(c, path) if c.big? || !path.include?(c) }
  end
end

spelunk("start")

@paths.each { |path| p path }
p @paths.count
