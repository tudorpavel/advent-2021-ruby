# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day04
  class Board < T::Struct
    extend T::Sig

    const :nums, T::Array[T::Array[Integer]]
    const :marked, T::Array[T::Array[T::Boolean]], default: Array.new(5) { Array.new(5, false) }
    prop :last_called_num, T.nilable(Integer)

    sig { params(lines: T::Array[String]).returns(Board) }
    def self.build(lines)
      Board.new(nums: lines.map { |line| line.split.map(&:to_i) })
    end

    sig { params(num: Integer).void }
    def mark_number(num)
      nums.each_with_index do |row, i|
        row.each_with_index do |n, j|
          T.must(marked[i])[j] = true if num == n
        end
      end

      @last_called_num = num
    end

    sig { returns(T::Boolean) }
    def line_win?
      (marked + marked.transpose).each do |row|
        return true if row.filter { |b| b }.size == 5
      end

      false
    end

    sig { returns(Integer) }
    def score
      raise ArgumentError, 'Score can only be calculated after a win' unless line_win?

      unmarked_sum = 0

      nums.each_with_index do |row, i|
        row.each_with_index do |n, j|
          unmarked_sum += n unless T.must(marked[i])[j]
        end
      end

      unmarked_sum * T.must(last_called_num)
    end
  end
end
