@memo = {}

def play(p1, p2, to_move = 1, roll = 1, rolled = 0)
  @memo[[p1, p2, to_move, roll, rolled]] ||=
    if p1[:score] >= 21
      [1, 0]
    elsif p2[:score] >= 21
      [0, 1]
    else
      [1, 2, 3].map do |die|
          if roll < 3
            play(p1, p2, to_move, roll + 1, rolled + die)
          elsif to_move == 1
            pos = p1[:pos] + die + rolled
            pos -= 10 if pos > 10
            play({ pos: pos, score: p1[:score] + pos }, p2, 2)
          else
            pos = p2[:pos] + die + rolled
            pos -= 10 if pos > 10
            play(p1, { pos: pos, score: p2[:score] + pos }, 1)
          end
        end
        .reduce([0, 0]) { |acc, a| [acc[0] + a[0], acc[1] + a[1]] }
    end
end

p play({ score: 0, pos: 5 }, { score: 0, pos: 9 }).max
