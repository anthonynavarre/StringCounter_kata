class String
  def add
    self.gsub!(/[^-|\d]/, ',')
    
    negatives = []
    sum = self.split(',').inject(0) do |sum, num|
      negatives.push(num.to_i) if i < 0
      sum + i
    end
    raise ArgumentError.new("Negatives not allowed. Passed negatives: #{negatives.join(',')}") if negatives.any?
    sum
  end
end
