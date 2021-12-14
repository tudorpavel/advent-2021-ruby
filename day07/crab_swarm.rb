# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day07
  class CrabSwarm < T::Struct
    extend T::Sig

    const :positions, T::Array[Integer]

    sig { params(input: String).returns(CrabSwarm) }
    def self.build(input)
      CrabSwarm.new(positions: input.split(',').map(&:to_i))
    end

    sig { returns(Integer) }
    def part1_minimum_fuel_cost
      T.must(
        (0..positions.max).map do |candidate|
          positions.map { |p| (p - candidate).abs }.sum
        end.min
      )
    end

    sig { returns(Integer) }
    def part2_minimum_fuel_cost
      T.must(
        (0..positions.max).map do |candidate|
          positions.map do |p|
            n = (p - candidate).abs
            (n * (n + 1)) / 2
          end.sum
        end.min
      )
    end
  end
end
