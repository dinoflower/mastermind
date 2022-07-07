# frozen_string_literal: true

require 'pry-byebug'

require_relative 'mastermind'

require_relative 'players'

def decide_codebreaker
  puts 'Would you like to break or make the code?'
  case gets.chomp
  when 'break'
    'codebreaker'
  when 'make'
    'codemaker'
  else
    puts "I didn't catch that."
    decide_codebreaker
  end
end

Game.new(HumanPlayer, ComputerPlayer).play_game
