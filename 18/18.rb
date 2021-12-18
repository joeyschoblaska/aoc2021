require "json"
require "pry"

numbers = File.readlines("18/sample.txt").map { |l| JSON.parse(l) }

# after addition: [[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]
# after explode:  [[[[0,7],4],[7,[[8,4],9]]],[1,1]]
# after explode:  [[[[0,7],4],[15,[0,13]]],[1,1]]
# after split:    [[[[0,7],4],[[7,8],[0,13]]],[1,1]]
# after split:    [[[[0,7],4],[[7,8],[0,[6,7]]]],[1,1]]
# after explode:  [[[[0,7],4],[[7,8],[6,0]]],[8,1]]
def reduce(number, depth = 0)
  return number if number.is_a?(Integer) && number < 10

  left, right =
    number.is_a?(Integer) ? [(number / 2.0).floor, (number / 2.0).ceil] : number

  return 0, left, right, true if depth == 4

  lv, llc, lrc, lx = reduce(left, depth + 1)
  rv, rlc, rrc, rx = reduce(right, depth + 1)
  lc = llc || rlc || 0
  rc = lrc || rrc || 0

  lv += lc and lc = 0 if lv.is_a?(Integer) && !lx
  rv += rc and rc = 0 if rv.is_a?(Integer) && !rx

  binding.pry if right == [6, 7]

  puts "#{depth}; [  #{left} (#{lc}) ,  #{right} (#{rc}) ]"

  [[lv, rv], lc, rc]
end

number = numbers[4]
p number
p reduce(number)
