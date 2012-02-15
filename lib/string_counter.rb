class String
  def add
    self.gsub!(/[^-|\d]/, ',')
    numbers = self.split(',')

    find_negatives(numbers)

    numbers.inject(0) do |sum, num|
      sum + num.to_i
    end
  end

  def find_negatives(numbers)
    negatives = []
    numbers.each do |num|
      n = num.to_i
      negatives.push(n) if n < 0
    end
    raise ArgumentError.new("Negatives not allowed. Passed negatives: #{negatives.join(',')}") if negatives.any?
  end
end
