pos = [0, 0]
aim = 0

File
  .open("2.txt")
  .each_line do |line|
    dir, x = line.split(" ")

    case dir
    when "up"
      aim -= x.to_i
    when "down"
      aim += x.to_i
    when "forward"
      pos = [pos[0] + x.to_i, pos[1] + aim * x.to_i]
    end
  end

p pos[0] * pos[1]
