# class to generate one two-player game of mastermind
class Game
  CODE_PIECES = %w[W U B R G C].freeze

  def initialize(codemaker, codebreaker)
    @codemaker = codemaker.new(self)
    @codebreaker = codebreaker.new(self)
    @turn = 1
    @output = %w[□ □ □ □]
    @winner = ''
    @indicies = {}
  end

  def play_game
    start_game
    @codemaker.return_code
    loop do
      @codebreaker.guess_code
      check_guess
      puts @output.join, "Turn #{@turn}"
      @turn += 1
      break if @turn > 12 || @winner == @codebreaker
    end
    puts 'The code was unbreakable.', @codemaker.code.join unless @winner == @codebreaker
  end

  def start_game
    puts 'The colors are W, U, B, R, G, and C.'
    puts '■ indicates a correct guess. ▤ indicates a color in the wrong place.'
    puts 'Make your guess: □□□□'
  end

  def check_guess
    collect_values
    return unless @output == %w[■ ■ ■ ■]

    puts 'The code has been broken!'
    @winner = @codebreaker
  end

  def collect_values
    @codebreaker.current_guess.each_with_index do |color, index|
      if @codemaker.code[index] == @codebreaker.current_guess[index]
        @indicies[:exact] = { index => color }
      elsif @codemaker.code.include?(color)
        @indicies[:close] = { index => color }
      else
        @indicies[:none] = { index => color }
      end
    end
    print @indicies
    set_output
   # loop do
     # break if @output.length == 4
#
     # @output << '□'
   # end
  end

  def set_output
    @output.clear
    @codemaker.code.each_index { |i| find_exact(i) }
    @codemaker.code.each_index { |i| find_match(i) }
    @codemaker.code.each_index { |i| no_match(i) }
  end

  def find_exact(num)
    return unless @indicies.dig(:exact, num)

    @output << '■'
  end

  def find_match(num)
    return unless @indicies.dig(:close, num)

    @output << '▤'
  end

  def no_match(num)
    return unless @indicies.dig(:none, num)

    @output << '□'
  end
end

# still returns too many matches
# test for exact matches first and remove them? then approximate?

# subclasses or modules for Computer and Human
# subclasses or modules for Codemaker and Codebreaker
# code is permutation of 4 (duplicates allowed)
# guess feedback in symbols? "blank" space: □ wrong position: ▤ correct guess: ■
# code needs to be secret but accessible by the guessing methods
# puts "■ ▤ □ ▤"

# Codemaker likely compares the guesses to the code (not manually)
# both can see the game
