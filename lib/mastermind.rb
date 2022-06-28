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
      @turn += 1
      puts @output.join, "Turn #{@turn}"
      break if @winner == @codebreaker || @turn > 12
    end
    puts 'The code was unbreakable.', @codemaker.code.join unless @winner == @codebreaker
  end

  def start_game
    puts 'The colors are W, U, B, R, G, and C.'
    puts '■ indicates a correct guess. ▤ indicates a color in the wrong place.'
    puts 'Turn 1', 'Make your guess: □□□□'
  end

  def check_guess
    @indicies = { exact: {}, close: {}, none: {} }
    collect_values
    return unless @output == %w[■ ■ ■ ■]

    puts 'The code has been broken!'
    @winner = @codebreaker
  end

  def collect_values
    @codebreaker.current_guess.each_with_index do |color, index|
      if @codemaker.code[index] == @codebreaker.current_guess[index]
        @indicies[:exact][index] = color
      elsif @codemaker.code.include?(color)
        determine_hints(color, index)
      else
        @indicies[:none][index] = color
      end
    end
    print @indicies
    set_output
  end

  def determine_hints(color, num)
    if color_count(color) >= @codebreaker.current_guess.count(color)
      @indicies[:close][num] = color
    elsif color_count(color) > @indicies[:close].values.count(color)
      @indicies[:close][num] = color
    else
      @indicies[:none][num] = color
    end
  end

  def color_count(color)
    if @indicies[:exact].value?(color)
      @codemaker.code.count(color) - @indicies[:exact].values.count(color)
    else
      @codemaker.code.count(color)
    end
  end

  def set_output
    @output.clear
    @codemaker.code.each_index do |i|
      find_exact(i)
      find_match(i)
    end
    @output.sort!
    @codemaker.code.each_index { |i| no_match(i) }
  end

  def find_exact(num)
    return unless @indicies.dig(:exact, num)

    @output << '■'
  end

  # find colors that are present but in the wrong position
  # no duplicates
  # almost like... if a color is present one time in current_guess and one time
  # in the code, but it's in the wrong position, only then should it register
  # @codemaker.code.count(color) - @indicies.dig(:exact).values.count >= @codebreaker.current_guess.count(color)
  # ugh that shortcut really set me back here

  def find_match(num)
    return unless @indicies.dig(:close, num)

    return if @codemaker.code[num] == @indicies.dig(:close, num)

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
