# frozen_string_literal: true

# instantiates a mastermind player
class Player
  attr_reader :game, :code, :player_type
  attr_accessor :current_guess

  def initialize(game)
    @game = game
    @code = []
    @current_guess = ''
  end
end

# designates the human player
class HumanPlayer < Player
  def initialize(game, player_type)
    super(game)
    @player_type = player_type
  end

  def self.player_type(answer)
    case answer
    when 'break'
      'codebreaker'
    when 'make'
      'codemaker'
    else
      puts "I didn't catch that."
    end
    HumanPlayer.new(game, answer)
  end
end

# designates the computer player
class ComputerPlayer < Player
  def initialize(game)
    super(game)
    @player_type = player_type
  end

  def self.player_type
    if HumanPlayer.player_type == 'codebreaker'
      'codemaker'
    else
      'codebreaker'
    end
  end
end

# mix in if player is codebreaker
module HumanCodebreaker
  def guess_code
    @current_guess = gets.chomp.upcase!.chars
  end
end

# designates the codemaker, if the player is codemaker
module HumanCodemaker
  def set_code
    @code = gets.chomp.match./[bcgrw]/i
    return unless @code < 4

    prompt_user
  end

  def prompt_user
    puts 'Your code must be 4 characters long and can only include W, U, B, R, G, and C.'
    until @code.length == 4
      entries = gets.chomp.match./[bcgrw]/i
      entries.each { |entry| @code << entry if @code.length < 4 } # you know what I mean
    end
  end
end

# designates the codebreaker, if the player is codemaker
module ComputerCodebreaker
  def guess_code
  end
end

# mix in if player is codebreaker
module ComputerCodemaker
  def return_code
    set_code
  end

  private

  def set_code
    4.times { @code << Game::CODE_PIECES.sample }
  end
end

# a conditional way to add modules to the classes?
# or just load up the game with the subclass based on what the human player chooses?
