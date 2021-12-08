MAPS = [
  [1, 1, 1, 0, 1, 1, 1], # 0
  [0, 0, 1, 0, 0, 1, 0], # 1
  [1, 0, 1, 1, 1, 0, 1], # 2
  [1, 0, 1, 1, 0, 1, 1], # 3
  [0, 1, 1, 1, 0, 1, 0], # 4
  [1, 1, 0, 1, 0, 1, 1], # 5
  [1, 1, 0, 1, 1, 1, 1], # 6
  [1, 0, 1, 0, 0, 1, 0], # 7
  [1, 1, 1, 1, 1, 1, 1], # 8
  [1, 1, 1, 1, 0, 1, 1] #  9
]

configs = %w[a b c d e f g].permutation.to_a

def s2m(signal, config)
  config.map { |c| signal.include?(c) ? 1 : 0 }
end

File
  .readlines("8/8.txt", chomp: true)
  .sum do |line|
    signals = line.scan(/[a-g]+/)
    config = configs.find { |c| signals.all? { |s| MAPS.index(s2m(s, c)) } }
    signals.last(4).map { |s| MAPS.index(s2m(s, config)) }.join.to_i
  end
  .then { |sum| p sum }
