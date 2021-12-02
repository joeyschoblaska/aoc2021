incs = 0
prev = nil

File
  .open("1.txt")
  .each_line do |line|
    cur = line.to_i
    incs += 1 if prev && cur > prev
    prev = cur
  end

p incs
