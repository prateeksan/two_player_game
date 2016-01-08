class Player

  attr_accessor :answer, :lives, :score

  def initialize
    @lives = 3
    @answer = nil
    @score = 0
  end
end