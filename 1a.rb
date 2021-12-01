incs = 0
prev = nil

File.open("1a.txt") do |file|
  while cur = file.gets
    cur = cur.to_i
    incs += 1 if prev && cur > prev
    prev = cur
  end
end

p incs
