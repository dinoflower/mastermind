class Player
  attr_reader :game
  attr_accessor :current_guess

  def initialize(game)
    @game = game
    @current_guess = ''
  end
end

class Codemaker < Player
  private
  def set_code
    @code = 4.times game.CODE_PIECES.sample.chars
  end
  def code
    @code
  end
end

class Codebreaker < Player
  def guess_code
    @current_guess = gets.chomp.chars
  end

  def has_won?
    @current_guess.eql?(code)
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