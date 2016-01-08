class Generator

  attr_reader :number_1, :number_2, :operator

  def initialize
    @number_1 = rand(21)
    @number_2 = rand(21)
    @operators = [:+, :-, :*]
    @operator = @operators.sample
  end

  def answer
    @number_1.send(@operator, @number_2)
  end


end



