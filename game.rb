require_relative ('./player')
require_relative ('./generator')
require 'colorize'
class Game

  attr_reader :player_1, :player_2

  def initialize
    @player_1 = Player.new
    @player_2 = Player.new
    @looper = false
  end

  def conversation_loop(player, player_1_name, player_2_name)

    player_name = @looper ? player_1_name : player_2_name

    generator = Generator.new

    puts "First question for #{player_name}...".yellow

    puts "What is #{generator.number_1} #{generator.operator} #{generator.number_2}?"

    player.answer = gets.chomp.to_i

    if player.answer == generator.answer
      puts "Good Job!".green
      player.score += 1

    else
      puts "Oops! Correct answer is #{generator.answer}".red
      player.lives -= 1
    end
    
    puts "Your score is now #{player.score}"
    puts "You have #{player.lives} left"

    if player.lives == 0
      puts "#{player_name} loses :("
      return "break"
    end


  end

  def game_loop

    puts "Player one enter name..."
    player_1_name = gets.chomp
    puts "Player two enter name..."
    player_2_name = gets.chomp

    while true do
      @looper = !@looper
      active_player = @looper ? @player_1 : @player_2
      conversation = conversation_loop(active_player, player_1_name, player_2_name)
      break if conversation == "break"
    end
  end

end

game = Game.new

game.game_loop