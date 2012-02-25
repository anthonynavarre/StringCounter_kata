class String
  def add
    raise ArgumentError.new("Negatives not allowed. Passed negatives: #{negatives.join(',')}") if negatives.any?
    numbers.inject(:+) || 0
  end

  protected

  def delimiter
    self.match(%r(^//(.)\n)) ? $1 : /\n|,/
  end

  def numbers
    self.split(self.delimiter).map &:to_i
  end

  def negatives
    self.numbers.select {|num| num < 0}
  end
end
