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

  def return_code
    set_code
  end

  def set_code
    input = /([bcgrw]){4}/i.match(gets.chomp)
    @code = input[0].upcase.chars
    return unless @code.length < 4

    prompt_user
  end

  def prompt_user
    puts 'Your code must be 4 characters long and can only include W, U, B, R, G, and C.'
    until @code.length == 4
      entries = /([bcgrw]){4}/i.match(gets.chomp)
      colors = entries[0].upcase.chars
      colors.each { |color| @code << color if @code.length < 4 }
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
    @current_guess = if @game.turn == 1
                       %w[W W W W]
                     elsif @game.turn > 1
                       review_output
                     end
  end

  def review_output
    case @output
    when %w[□ □ □ □]
      @possible_colors -= @current_guess
      4.times { temp << @possible_colors.sample }
      temp
    when %w[▤ ▤ ▤ ▤]
      4.times { temp << @current_colors.sample(4) }
      temp
    else
      attempt_break
    end
  end

  def attempt_break
    if @output.include?('■')
      @current_guess.sample(@output.count('■')) +
        @possible_colors.sample(@output.length - @output.count('■'))
    else
      @possible_colors.sample(4)
    end
  end

  def return_code
    set_code
  end

  private

  def set_code
    4.times { @code << Game::CODE_PIECES.sample }
  end
end
