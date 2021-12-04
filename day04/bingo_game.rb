# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative './board'

module Day04
  class BingoGame < T::Struct
    extend T::Sig

    const :nums, T::Array[Integer]
    const :boards, T::Array[Board]

    sig { params(input: String).returns(BingoGame) }
    def self.build(input)
      input_parts = input.split("\n\n")

      nums = T.must(input_parts.first).split(',').map(&:to_i)
      boards = T.must(input_parts[1..]).map do |part|
        Board.build(part.split("\n"))
      end

      BingoGame.new(nums: nums, boards: boards)
    end

    sig { returns(Day04::Board) }
    def first_board_to_win
      nums.each do |num|
        boards.each do |board|
          board.mark_number(num)

          return board if board.line_win?
        end
      end

      raise ArgumentError, 'No winning board found'
    end

    sig { returns(Day04::Board) }
    def last_board_to_win
      nums.each do |num|
        remaining_boards = boards.filter { |board| !board.line_win? }
        remaining_boards.each { |board| board.mark_number(num) }

        if remaining_boards.size == 1
          last_board = T.must(remaining_boards.first)
          return last_board if last_board.line_win?
        end
      end

      raise ArgumentError, 'More than one board won last'
    end
  end
end
