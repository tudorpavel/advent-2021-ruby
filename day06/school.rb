# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day06
  class School < T::Struct
    extend T::Sig

    const :fish, T::Array[Integer]
    prop :partial_solutions, T::Hash[String, Integer], default: {}

    sig { params(input: String).returns(School) }
    def self.build(input)
      School.new(fish: input.split(',').map(&:to_i))
    end

    sig { params(day_count: Integer).returns(Integer) }
    def fish_count_after(day_count)
      fish.map { |f| fish_count(day_count, f) }.sum
    end

    private

    sig { params(total: Integer, current: Integer).returns(Integer) }
    def fish_count(total, current)
      current += 1
      return 1 if total < current

      after = (total - current)
      a = partial_solutions[[after, 6].join(',')] ||= fish_count(after, 6)
      b = partial_solutions[[after, 8].join(',')] ||= fish_count(after, 8)
      a + b
    end
  end
end
