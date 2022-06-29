# frozen_string_literal: true

require 'pry-byebug'

require_relative 'mastermind'

require_relative 'players'

def choose_role
  puts 'Would you like to play as the codebreaker?', 'y/n'
  case gets.chomp.downcase
  when 'y'
    codebreaker
  when 'n'
    codemaker
  else
    puts "I'm sorry - I didn't catch that."
    choose_role
  end
end

Game.new(Codemaker, Codebreaker).play_game
