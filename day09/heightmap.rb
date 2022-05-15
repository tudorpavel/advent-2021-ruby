# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day09
  class Heightmap < T::Struct
    extend T::Sig

    const :map, T::Array[T::Array[Integer]]

    sig { params(input: String).returns(Heightmap) }
    def self.build(input)
      Heightmap.new(
        map: input.strip.split("\n").map { |line| line.strip.chars.map(&:to_i) }
      )
    end

    sig { returns(Integer) }
    def part1_risk_level_sum
      sum = 0

      map.each_with_index do |row, i|
        row.each_with_index do |height, j|
          sum += risk_level(height) if low_point?(i, j)
        end
      end

      sum
    end

    private

    sig { params(row: Integer, col: Integer).returns(T::Boolean) }
    def low_point?(row, col) # rubocop:disable Metrics/AbcSize
      [
        row.positive?                    ? T.must(map[row - 1])[col] : 10,
        col < T.must(map.first).size - 1 ? T.must(map[row])[col + 1] : 10,
        row < map.size - 1               ? T.must(map[row + 1])[col] : 10,
        col.positive?                    ? T.must(map[row])[col - 1] : 10
      ].all? do |adjacent_height|
        T.must(adjacent_height) > T.must(T.must(map[row])[col])
      end
    end

    sig { params(height: Integer).returns(Integer) }
    def risk_level(height)
      height + 1
    end
  end
end
