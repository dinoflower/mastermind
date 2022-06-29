# frozen_string_literal: true

# instantiates a mastermind player
class Player
  attr_reader :game, :code
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
end

# designates the computer player
class ComputerPlayer
  def initialize(game, player_type)
    super(game)
    @player_type = player_type
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

# mix in if player is codebreaker
module HumanCodebreaker
  def guess_code
    @current_guess = gets.chomp.upcase!.chars
  end
end

# designates the codemaker, if the player is codemaker
class Codemaker < HumanPlayer
end

# designates the codebreaker, if the player is codemaker
class Codebreaker < ComputerPlayer
end

# a conditional way to add modules to the classes?
# or just load up the game with the subclass based on what the human player chooses?
