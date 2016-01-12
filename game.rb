require_relative ('./player')
require_relative ('./generator')
require_relative('./math_game_error')
require 'colorize'
require 'pry'

# Description:
#   This is a terminal two player game where both players take turns to answer simple Math Questions.
#   Each player starts with 3 lives and if all lives are lost, the game is over.
#   The score variable doesn't really do anything.
class Game

  attr_reader :player_1, :player_2

  def initialize
    @player_1 = Player.new
    @player_2 = Player.new
    @looper = false
  end

  def display_results(player, generator)
    if player.answer == generator.answer
      puts "Good Job!".green
      player.score += 1
    else
      puts "Oops! Correct answer is #{generator.answer}".red
      player.lives -= 1
    end
  end

  def display_question(player_name, generator)
    puts "Question for #{player_name}...".yellow
    puts "What is #{generator.number_1} #{generator.operator} #{generator.number_2}?"
  end

  def display_score(player_name, player)
    puts "#{player_name} score is now #{player.score}"
    puts "#{player_name} have #{player.lives} left"
  end

  def input_name
    begin   
      name = gets.chomp
      raise MathGameError::InvalidNameError.new("Name can't be blank, enter name again") if name == "" 
    rescue MathGameError::InvalidNameError => e
      puts e.message
      retry
    end
    return name
  end

  def input_player_answer
    begin
      player_answer = gets.chomp
      unless player_answer.match(/^-*\d+$/) # player_answer starts with 0 or more '-' followed by 1 or more numbers only
        raise MathGameError::InvalidAnswerError.new("Answer can contain digits only. Enter answer again") 
      end
    rescue MathGameError::InvalidAnswerError => e
      puts e.message
      retry
    end
    return player_answer.to_i
  end

  def game_over(player_name, player)
    if player.lives == 0
      puts "#{player_name} loses :(".red
      return "break"
    end
  end

  def conversation_loop(player, player_1_name, player_2_name)
    player_name = @looper ? player_1_name : player_2_name

    generator = Generator.new

    display_question(player_name, generator)

    player.answer = input_player_answer

    display_results(player, generator)
    
    display_score(player_name, player)

    game_over(player_name, player)

  end

  def game_loop

    puts "Player one enter name..."
    player_1_name = input_name
    puts "Player two enter name..."
    player_2_name = input_name

    while true do
      @looper = !@looper
      active_player = @looper ? @player_1 : @player_2
      conversation = conversation_loop(active_player, player_1_name, player_2_name)
      break if conversation == "break"
    end
  end

end

# intantiate the game
game = Game.new

# start the game
game.game_loop