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

sum =
  lines.sum do |line|
    signals = line.scan(/[a-g]+/)

    config =
      configs.find do |conf|
        signals.all? do |signal|
          MAPS.any? { |map| map == conf.map { |c| signal.include?(c) ? 1 : 0 } }
        end
      end

    line
      .split(" | ")
      .last
      .scan(/[a-g]+/)
      .map do |signal|
        MAPS.index do |map|
          map == config.map { |c| signal.include?(c) ? 1 : 0 }
        end
      end
      .join
      .to_i
  end

p sum
