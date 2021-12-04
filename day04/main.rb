# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative './bingo_game'

input = ARGF.read

game = Day04::BingoGame.build(input)
winning_board = game.first_board_to_win
puts "Part1: #{winning_board.score}"

game = Day04::BingoGame.build(input)
last_board_to_win = game.last_board_to_win
puts "Part2: #{last_board_to_win.score}"
