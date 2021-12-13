# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day06
  class School < T::Struct
    extend T::Sig

    const :fish, T::Array[Integer]

    sig { params(input: String).returns(School) }
    def self.build(input)
      School.new(fish: input.split(',').map(&:to_i))
    end

    sig { returns(Integer) }
    def part1_fish_count_after_80_days
      80.times.reduce(fish) { |fish, _| step_one_day(fish) }.size
    end

    private

    sig { params(fish: T::Array[Integer]).returns(T::Array[Integer]) }
    def step_one_day(fish)
      new_fish = []

      fish.each do |fish_age|
        if fish_age.zero?
          new_fish << 6
          new_fish << 8
        else
          new_fish << (fish_age - 1)
        end
      end

      new_fish
    end
  end
end
