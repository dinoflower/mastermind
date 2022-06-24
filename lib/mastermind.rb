# class to generate one two-player game of mastermind
class Game
  CODE_PIECES = ['w', 'U', 'B', 'R', 'G', 'C']

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker.new(self)
    @codebreaker = codebreaker.new(self)
    @turn = 0
    @output = '□□□□'
  end

  def play_game
    puts 'The colors are W, U, B, R, G, and C.'
    loop do
      if @turn == 0
        @codemaker.set_code
      else
        @codebreaker.guess_code
        check_code
      end
      puts @output
      @turn += 1
      break unless @turn < 12 && !@codebreaker.won?
    end
    unless @codebreaker.won? puts 'The code was unbreakable.'
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
    i = 0
    loop do
      if @codemaker.code[i] == @codebreaker.current_guess[i]
        @output[i] = '■'
      elsif @codemaker.code.include?(@codebreaker.current_guess[i])
        @output[i] = '▤'
      else
        @output[i] = '□'
      end
      i += 1
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