require_relative "execute"
require "pry"

def test(i, w, z)
  execute(@instruction_sets[i], [w], 0, 0, 0, z)[3]
end

binding.pry
