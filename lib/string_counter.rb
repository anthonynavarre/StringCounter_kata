class String
  def add
    if self =~ %r(^//(.)\n)
      delimiter = $1
    else
      delimiter = /\n|,/
    end

    negatives = []
    sum = self.split(delimiter).inject(0) do |sum, num|
      i = num.to_i
      negatives.push(i) if i < 0
      sum + i
    end
    raise ArgumentError.new("Negatives not allowed. Passed negatives: #{negatives.join(',')}") if negatives.any?
    sum
  end
end
