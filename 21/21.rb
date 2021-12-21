rolls = 0
die = 1
to_move = 0
players = [{ pos: 5, score: 0 }, { pos: 9, score: 0 }]

until players.any? { |p| p[:score] >= 1000 }
  dist = 0

  3.times do
    dist += die
    rolls += 1
    die += 1
    die = 1 if die > 100
  end

  mod = (players[0][:pos] + dist) % 10
  players[0][:pos] = mod == 0 ? 10 : mod
  players[0][:score] += players[0][:pos]
  players.rotate!
end

p [rolls, players]
p rolls * players.map { |p| p[:score] }.min
