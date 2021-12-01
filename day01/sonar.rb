# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day01
  class Sonar < T::Struct
    extend T::Sig

    const :measurements, T::Array[Integer]

    sig { params(lines: T::Array[String]).returns(Sonar) }
    def self.build(lines)
      Sonar.new(measurements: lines.map(&:to_i))
    end

    sig { returns(Integer) }
    def increase_count_part1
      increase_count(measurements)
    end

    sig { returns(Integer) }
    def increase_count_part2
      increase_count(
        measurements.each_cons(3).map(&:sum)
      )
    end

    private

    sig { params(nums: T::Array[Integer]).returns(Integer) }
    def increase_count(nums)
      nums
        .each_cons(2)
        .map { |(a, b)| T.must(a) < T.must(b) ? 1 : 0 }
        .sum
    end
  end
end
