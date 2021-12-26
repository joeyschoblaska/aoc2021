require_relative "execute"
require "json"

def test(i, w, z)
  execute(@instruction_sets[i], [w], 0, 0, 0, z)[3]
end

candidates = JSON.parse(File.read("24/candidates.json"))
zout = 0
number = ""

(0..13).each do |i|
  candidate = candidates[i.to_s].select { |c| c[1] == zout }.max_by { |c| c[0] }

  zout = candidate[2]
  number << candidate[0]
end

p number
