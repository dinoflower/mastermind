# frozen_string_literal: true

require 'pry-byebug'

require_relative 'mastermind'

# instantiates a mastermind player
class Player
  attr_reader :game, :code, :player_type
  attr_accessor :current_guess

  def initialize(game)
    @game = game
    @code = []
    @current_guess = ''
    @turn = game.turn
  end
end

# designates the human player
class HumanPlayer < Player
  def initialize(game, player_type)
    super(game)
    @player_type = player_type
  end

  def return_code
    set_code
  end

  def set_code
    input = gets.chomp.upcase.scan(/[bcgruw]/i)
    @code = input
    return unless @code.length < 4

    prompt_user
  end

  def prompt_user
    puts 'Your code must be 4 characters long and can only include W, U, B, R, G, and C.'
    until @code.length == 4
      entries = gets.chomp.upcase.scan(/[bcgruw]/i)
      entries.each { |entry| @code << entry if @code.length < 4 }
    end
  end

  def guess_code
    @current_guess = gets.chomp.upcase.chars
  end
end

# designates the computer player
class ComputerPlayer < Player
  def initialize(game)
    super(game)
    @player_type = player_type
    @possible_colors = Game::CODE_PIECES
  end

  def self.player_type
    if HumanPlayer.player_type == 'codebreaker'
      'codemaker'
    else
      'codebreaker'
    end
  end

  def guess_code
    @current_guess = if @game.turn == 1 # currently not working here - have also tried @turn
                       %w[W W W W]
                     elsif @game.turn > 1 # may have problem with (self) as arg on init
                       review_output
                     end
    p @current_guess.join
  end

  def review_output
    case @game.output
    when %w[□ □ □ □]
      @possible_colors -= @current_guess
      Array.new(4) { @possible_colors.sample }
    when %w[▤ ▤ ▤ ▤]
      @current_guess.sample(4)
    else
      attempt_break
    end
  end

  def attempt_break
    if @game.output.include?('■')
      @current_guess.sample(@game.output.count('■')) +
        (Array.new(4 - @game.output.count('■')) { @possible_colors.sample })
    else
      Array.new(4) { @possible_colors.sample }
    end
  end

  def return_code
    set_code
  end

  private

  def set_code
    4.times { @code << @possible_colors.sample }
  end
end
