sum =
  File
    .readlines("8/8.txt", chomp: true)
    .map do |line|
      line.split(" | ")[1]
        .split(" ")
        .select { |w| [2, 3, 4, 7].include?(w.length) }
        .count
    end
    .sum

p sum
