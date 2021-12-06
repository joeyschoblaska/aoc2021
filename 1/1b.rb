incs = 0
buff = []

File
  .open("1/1.txt")
  .each_line do |line|
    buff << line.to_i
    next unless buff.count == 4
    incs += 1 if buff[0, 3].sum < buff[1, 3].sum
    buff.shift
  end

p incs
