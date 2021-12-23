require "set"

########################
#0 1 2 3 4 5 6 7 8 9 10#
#####11##13##15##17#####
#####12##14##16##18#####
########################

@outs = {
  0 => [1],
  1 => [0, 2],
  2 => [1, 3, 11],
  3 => [2, 4],
  4 => [3, 5, 13],
  5 => [4, 6],
  6 => [5, 7, 15],
  7 => [6, 8],
  8 => [7, 9, 17],
  9 => [8, 10],
  10 => [9],
  11 => [2, 12],
  12 => [11],
  13 => [4, 14],
  14 => [13],
  15 => [6, 16],
  16 => [15],
  17 => [8, 18],
  18 => [17]
}

@energies = { "A" => 1, "B" => 10, "C" => 100, "D" => 1000 }
@goal = [nil] * 11 + %w[A A B B C C D D]

def find_path(board, from, to)
  testing = [[from]]
  found = []

  until testing.empty?
    test = testing.pop

    if test.last == to
      found << test
    else
      @outs[test.last].each do |i|
        next if test.include?(i) || board[i]
        testing << (test + [i])
      end
    end
  end

  found.min_by(&:count)
end

def legal_moves_from_to(board, from, to)
  to.map do |to|
    next if from == to
    path = find_path(board, from, to)
    next unless path
    [from, to, (path.count - 1) * @energies[board[from]]]
  end.compact
end

def legal_moves(board)
  moves =
    board
      .each_with_index
      .map do |piece, from|
        next unless piece

        a, b = @goal.each_index.select { |i| @goal[i] == piece }.sort
        legal_goals = []
        legal_goals << a if board[a].nil? && board[b] == piece
        legal_goals << b if board[a].nil? && board[b].nil?

        if from > 10
          # in a room
          legal_moves_from_to(board, from, [0, 1, 3, 5, 7, 9, 10] + legal_goals)
        else
          # in the hallway
          [legal_moves_from_to(board, from, legal_goals).max_by { |e| e[2] }]
        end
      end
      .flatten(1)
      .compact

  goal_move = moves.find { |m| m[1] > 10 }
  goal_move ? [goal_move] : moves
end

def perform_move(board, from, to)
  board.each_with_index.map do |piece, i|
    if i == from
      nil
    elsif i == to
      board[from]
    else
      piece
    end
  end
end

initial = [nil] * 11 + %w[A B D C B D C A]
costs = {}
candidates = Set.new

legal_moves(initial).each do |from, to, cost|
  result = perform_move(initial, from, to)
  candidates << result
  costs[result] = cost
end

loop do
  checking = candidates.sort_by { |c| costs[c] }[0, 1000]

  checking.each do |candidate|
    candidates.delete(candidate)

    p costs[candidate]

    legal_moves(candidate).each do |from, to, cost|
      new_cost = costs[candidate] + cost
      result = perform_move(candidate, from, to)

      next if costs[result] && costs[result] < new_cost

      candidates << result
      costs[result] = new_cost
    end
  end

  break if costs[@goal] && costs[@goal] < costs[checking[0]]
  raise "ran out of candidates" if candidates.empty?
end

puts "result: #{costs[@goal]}"
