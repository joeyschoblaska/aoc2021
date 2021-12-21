@scores = 0

def play(p1pos, p1score, p2pos, p2score, to_move = 1, roll = 1, rolled = 0)
  if p1score >= 10
    @scores += 1
    p @scores if @scores % 1_000_000 == 0
    [1, 0]
  elsif p2score >= 10
    @scores += 1
    p @scores if @scores % 1_000_000 == 0
    [0, 1]
  else
    [1, 2, 3].map do |die|
        if roll < 3
          play(p1pos, p1score, p2pos, p2score, to_move, roll + 1, rolled + die)
        elsif to_move == 1
          pos = (p1pos + die + rolled) % 10
          pos = 1 if pos == 0
          play(pos, p1score + pos, p2pos, p2score, 2)
        else
          pos = (p2pos + die + rolled) % 10
          pos = 1 if pos == 0
          play(p1pos, p1score, pos, p2score + pos, 1)
        end
      end
      .reduce([0, 0]) { |acc, a| [acc[0] + a[0], acc[1] + a[1]] }
  end
end

p play(4, 0, 8, 0)
