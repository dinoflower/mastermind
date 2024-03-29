require_relative 'players'

# class to generate one two-player game of mastermind
class Game
  CODE_PIECES = %w[W U B R G C].freeze

  attr_reader :turn, :output

  def initialize(human_player, computer_player)
    @human = human_player.new(self, decide_codebreaker)
    @computer = computer_player.new(self)
    @codemaker = @human.player_type == 'codemaker' ? @human : @computer
    @codebreaker = @human.player_type == 'codebreaker' ? @human : @computer
    @turn = 1
    @output = %w[□ □ □ □]
    @winner = ''
    @indicies = {}
  end

  def play_game
    start_game
    @codemaker.return_code
    loop do
      puts "Turn #{@turn}"
      @codebreaker.guess_code
      check_guess
      @turn += 1
      break if @winner == @codebreaker || @turn > 12
    end
    puts 'The code was unbreakable.', @codemaker.code.join unless @winner == @codebreaker
  end

  def start_game
    puts 'The colors are W, U, B, R, G, and C.'
    puts '■ indicates a correct guess. ▤ indicates a color in the wrong place.'
    opener = @codebreaker == @human ? 'Make your guess: □□□□' : 'Write your code: □□□□'
    puts opener
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
      next unless @codemaker.code[index] == @codebreaker.current_guess[index]

      @indicies[:exact][index] = color
    end
    @codebreaker.current_guess.each_with_index do |color, index|
      next unless @codemaker.code.include?(color)

      determine_hints(color, index)
    end
    set_output
  end

  def determine_hints(color, num)
    return if @indicies[:exact][num] == color

    if color_count(color) >= @codebreaker.current_guess.count(color)
      @indicies[:close][num] = color
    elsif color_count(color) > @indicies[:close].values.count(color)
      @indicies[:close][num] = color
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
    4.times { @output << '□' if @output.length < 4 }
    puts @output.join
  end

  def find_exact(num)
    return unless @indicies.dig(:exact, num)

    @output << '■'
  end

  def find_match(num)
    return unless @indicies.dig(:close, num)

    @output << '▤'
  end
end
