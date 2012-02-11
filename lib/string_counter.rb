class String
  def add
    numbers = self.split(',')
    sum = 0
    numbers.each do |num|
      sum += num.to_i
    end
    sum
  end
end
