class String
  def explode!
    return false unless needs_exploding?

    i = explode_i

    left = self[0..i - 1]
    mid = self[i..-1][/\[[\d,]+\]/]
    right = self[i + mid.length..-1]
    lcarry, rcarry = mid.scan(/\d+/).map(&:to_i)

    replace [
              left
                .reverse
                .sub(/\d+/) { |s| (s.reverse.to_i + lcarry).to_s.reverse }
                .reverse,
              "0",
              right.sub(/\d+/) { |s| s.to_i + rcarry }
            ].join
  end

  def split!
    return false unless needs_splitting?

    sub!(/\d{2,}/) do |s|
      n = s.to_i
      "[#{(n / 2.0).floor},#{(n / 2.0).ceil}]"
    end
  end

  def needs_exploding?
    !!explode_i
  end

  def needs_splitting?
    self =~ /\d{2,}/
  end

  def reduce!
    while needs_exploding? || needs_splitting?
      needs_exploding? ? explode! : split!
    end

    self
  end

  def explode_i
    d = 0

    chars.each_with_index do |c, i|
      d += 1 if c == "["
      d -= 1 if c == "]"
      return i if d == 5
    end

    return nil
  end
end
