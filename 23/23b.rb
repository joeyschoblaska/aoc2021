require_relative "shared"

########################
#0 1 2 3 4 5 6 7 8 9 10#
#####11##15##19##23#####
#####12##16##20##24#####
#####13##17##21##25#####
#####14##18##22##26#####
########################

@outs = {
  0 => [1],
  1 => [0, 2],
  2 => [1, 3, 11],
  3 => [2, 4],
  4 => [3, 5, 15],
  5 => [4, 6],
  6 => [5, 7, 19],
  7 => [6, 8],
  8 => [7, 9, 23],
  9 => [8, 10],
  10 => [9],
  11 => [2, 12],
  12 => [11, 13],
  13 => [12, 14],
  14 => [13],
  15 => [4, 16],
  16 => [15, 17],
  17 => [16, 18],
  18 => [17],
  19 => [6, 20],
  20 => [19, 21],
  21 => [20, 22],
  22 => [21],
  23 => [8, 24],
  24 => [23, 25],
  25 => [24, 26],
  26 => [25]
}

@goal = [nil] * 11 + %w[A A A A B B B B C C C C D D D D]

def print_board(board)
  sq = proc { |i| board[i] || "." }

  puts "#############"
  puts "##{(0..10).map { |i| sq.call(i) }.join}#"
  puts "####{sq.call(11)}##{sq.call(15)}##{sq.call(19)}##{sq.call(23)}###"
  puts "  ##{sq.call(12)}##{sq.call(16)}##{sq.call(20)}##{sq.call(24)}#  "
  puts "  ##{sq.call(13)}##{sq.call(17)}##{sq.call(21)}##{sq.call(25)}#  "
  puts "  ##{sq.call(14)}##{sq.call(18)}##{sq.call(22)}##{sq.call(26)}#  "
  puts "  #########"
  puts
end

def legal_moves(board)
  moves =
    board
      .each_with_index
      .map do |piece, from|
        next unless piece

        a, b, c, d = @goal.each_index.select { |i| @goal[i] == piece }.sort

        next if from == d
        next if from == c && board[d] == piece
        next if from == b && board[c..d].all? { |s| s == piece }
        next if from == a && board[b..d].all? { |s| s == piece }

        goals = []
        goals << a if board[a].nil? && board[b..d].all? { |s| s == piece }
        if board[a..b].all?(&:nil?) && board[c..d].all? { |s| s == piece }
          goals << b
        end
        goals << c if board[a..c].all?(&:nil?) && board[d] == piece
        goals << d if board[a..d].all?(&:nil?)

        if from > 10
          legal_moves_from_to(board, from, [0, 1, 3, 5, 7, 9, 10] + goals)
        else
          legal_moves_from_to(board, from, goals)
        end
      end
      .flatten(1)
      .compact

  goal_moves = moves.select { |m| m[1] > 10 }
  goal_moves.any? ? goal_moves : moves
end

initial = [nil] * 11 + %w[A D D B D C B C B B A D C A C A] # input
# initial = [nil] * 11 + %w[B D D A C C B D B B A C D A C A] # sample

solve(initial)
