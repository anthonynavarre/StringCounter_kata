class String
  def add
    self.split(',').inject(0) { |sum, num| sum + num.to_i }
  end
end
