require "set"
require "pry"

@energies = { "A" => 1, "B" => 10, "C" => 100, "D" => 1000 }
@paths = {}

def find_path(board, from, to)
  path =
    @paths[[from, to]] ||=
      begin
        testing = [[from]]
        found = []

        until testing.empty?
          test = testing.pop

          if test.last == to
            found << test
          else
            @outs[test.last].each do |i|
              next if test.include?(i)
              testing << (test + [i])
            end
          end
        end

        found.min_by(&:count)
      end

  path[1..-1].all? { |s| board[s].nil? } ? path : nil
end

def legal_moves_from_to(board, from, to)
  to.map do |to|
    next if from == to
    next unless board[to].nil?
    path = find_path(board, from, to)
    next unless path
    [from, to, (path.count - 1) * @energies[board[from]]]
  end.compact
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

def solve(initial)
  costs = {}
  candidates = Set.new

  legal_moves(initial).each do |from, to, cost|
    result = perform_move(initial, from, to)
    candidates << result
    costs[result] = cost
  end

  loop do
    checking = candidates.sort_by { |c| costs[c] }[0, 1_000]

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
    break if candidates.empty?
  end

  puts "result: #{costs[@goal]}"
end
