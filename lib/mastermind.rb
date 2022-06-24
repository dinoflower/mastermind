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
    indices = {}
    @codebreaker.current_guess each_with_index do |color, index|
      if @codemaker.code.include?(color)
        indicies << index[color]
      end
      # iterate i = 0 i < 4 etc ...?
      # @codemaker.code[index] == @codebreaker.current_guess[index]
    end
  end
end

# 12 turns or you lose - loop
# class for Game and class for Players
# subclasses or modules for Computer and Human
# subclasses or modules for Codemaker and Codebreaker
# code made up of numbers [1, 2, 3, 4, 5, 6]
# or colors [W, U, B, R, G, C] (likely array, constant)
# code is permutation of 4 (duplicates allowed)
# guess feedback in symbols? "blank" space: □ wrong position: ▤ correct guess: ■
# code needs to be secret but accessible by the guessing methods
# compare input against the code (either as array or string)
# note exact_matches (maybe store in hash? index => guess symbol?)
# then pseudo_matches (value is present but not at index, can also store in hash?)
# default value is blank
# create array of values from the hash and puts result
# if all matches, Codebreaker wins
# elsif that was Guess 12, Codemaker wins
# otherwise, the game continues
# puts "■ ▤ □ ▤"

# Codemaker can "see" the CODE_PIECES and guesses
# can also "see" and make (edit from ""?) the code
# Codebreaker can make guesses (edit from □□□□?)
# Codemaker likely compares the guesses to the code (not manually)
# both can see the game
