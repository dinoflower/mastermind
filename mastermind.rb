class Game
  CODE_PIECES = ['w', 'U', 'B', 'R', 'G', 'C']

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker.new(self)
    @codebreaker = codebreaker.new(self)
    @turn = 1
  end

  def play_game
    while @turn < 12 # and code not solved
      if @turn == 1
        @codemaker # make code
      else
        @codebreaker # guess code
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
puts "■ ▤ □ ▤"

# Codemaker can "see" the CODE_PIECES and guesses
# can also "see" and make (edit from ""?) the code
# Codebreaker can make guesses (edit from □□□□?)
# Codemaker likely compares the guesses to the code (not manually)
# both can see the game