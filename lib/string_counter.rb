class String
  def add
    self.split(/\D|,/).inject(0) { |sum, num| sum + num.to_i }
  end
end
