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

# designates the codemaker
class Codemaker < Player
  def return_code
    set_code
  end

  private

  def set_code
    4.times { @code << Game::CODE_PIECES.sample }
  end
end

# designates the codebreaker
class Codebreaker < Player
  def guess_code
    @current_guess = gets.chomp.chars
  end
end

# module Codeable # include these for human players?
#   def set_code
#     @code = gets.chomp.chars (check length and use regexp)
#   end
# end

# module Playable
#   def guess_code
#   end
# end
