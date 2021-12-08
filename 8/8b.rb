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

lines = File.readlines("8/8.txt", chomp: true)
configs = %w[a b c d e f g].permutation.to_a

def signal_to_map(signal, config) # (acf, [a b c d e f g]) = [1 0 1 0 0 1 0]
  config.map { |c| signal.include?(c) ? 1 : 0 }
end

sum =
  lines.sum do |line|
    signals = line.scan(/[a-g]+/)

    config =
      configs.find do |config|  # find the config
        signals.all? do |signal|  # where all the signals
          MAPS.include?(signal_to_map(signal, config)) # have a valid map
        end
      end

    # value == index of matching map using correct config
    signals.last(4).map { |s| MAPS.index(signal_to_map(s, config)) }.join.to_i
  end

p sum
