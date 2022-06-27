# frozen_string_literal: true

require 'pry-byebug'

require_relative 'mastermind'

require_relative 'players'

Game.new(Codemaker, Codebreaker).play_game
