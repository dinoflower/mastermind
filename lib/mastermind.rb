# frozen_string_literal: true

# class to generate one two-player game of mastermind
class Game
  CODE_PIECES = %w[W U B R G C].freeze

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker.new(self)
    @codebreaker = codebreaker.new(self)
    @turn = 0
    @output = '□□□□'
  end

  def play_game
    puts 'The colors are W, U, B, R, G, and C.'
    @codemaker.set_code
    loop do
      @codebreaker.guess_code
      check_code
      puts @output
      @turn += 1
      break if @turn > 12 || @codebreaker.won?
    end
    puts 'The code was unbreakable.' unless @codebreaker.won?
  end

  def check_code
    if @codebreaker.won?
      puts 'The code has been broken!'
      @output = '■■■■'
    else
      set_output
    end
  end

  def set_output
    (0..3).each do |i|
      @output[i] = if @codemaker.code[i] == (@codebreaker.current_guess[i])
                     '■'
                   elsif @codemaker.code.include?(@codebreaker.current_guess[i])
                     '▤'
                   else
                     '□'
                   end
    end
  end
end

# subclasses or modules for Computer and Human
# subclasses or modules for Codemaker and Codebreaker
# code is permutation of 4 (duplicates allowed)
# guess feedback in symbols? "blank" space: □ wrong position: ▤ correct guess: ■
# code needs to be secret but accessible by the guessing methods
# puts "■ ▤ □ ▤"

# Codemaker can "see" the CODE_PIECES and guesses
# can also "see" and make (edit from ""?) the code
# Codebreaker can make guesses (edit from □□□□?)
# Codemaker likely compares the guesses to the code (not manually)
# both can see the game
