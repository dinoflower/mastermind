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

# codemaker module for human and computer classes
module Codemaker
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

    def return_code
      set_code
    end

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

    def return_code
      set_code
    end

    private

    def set_code
      4.times { @code << Game::CODE_PIECES.sample }
    end
  end
end

# codebreaker module for human and computer classes
module Codebreaker
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

    def guess_code
      @current_guess = gets.chomp.upcase!.chars
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

    def guess_code
      # does stuff with array
    end
  end
end
