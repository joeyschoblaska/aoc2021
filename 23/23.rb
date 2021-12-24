require_relative "shared"

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

@goal = [nil] * 11 + %w[A A B B C C D D]

def legal_moves(board)
  moves =
    board
      .each_with_index
      .map do |piece, from|
        next unless piece

        a, b = @goal.each_index.select { |i| @goal[i] == piece }.sort
        goals = []
        goals << a if board[a].nil? && board[b] == piece
        goals << b if board[a].nil? && board[b].nil?

        if from > 10
          # in a room
          legal_moves_from_to(board, from, [0, 1, 3, 5, 7, 9, 10] + goals)
        else
          # in the hallway
          [legal_moves_from_to(board, from, goals).max_by { |e| e[1] }]
        end
      end
      .flatten(1)
      .compact

  goal_move = moves.find { |m| m[1] > 10 }
  goal_move ? [goal_move] : moves
end

initial = [nil] * 11 + %w[A B D C B D C A]

solve(initial)
