# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day17
  class TrickShot < T::Struct
    extend T::Sig

    const :min_x, Integer
    const :max_x, Integer
    const :min_y, Integer
    const :max_y, Integer

    sig { params(input: String).returns(TrickShot) }
    def self.build(input)
      _, coords = input.strip.split('target area: x=')
      x_part, y_part = T.must(coords).split(', y=')
      min_x, max_x = T.must(x_part).split('..')
      min_y, max_y = T.must(y_part).split('..')

      TrickShot.new(min_x: min_x.to_i, max_x: max_x.to_i,
                    min_y: min_y.to_i, max_y: max_y.to_i)
    end

    sig { returns(Integer) }
    def part1_max_height
      # Due to the gravity rule the first step below 0 on Y axis will be the initial Y velocity plus 1
      # The max height will be reached if this first step below 0 barely catches the target
      # So the initial Y velocity should be (min_y.abs - 1)
      # Calculating the height is done by computing the sequence 4 + 3 + 2 + 1 + 0 (where initial Y is 4)
      ((min_y.abs - 1) * min_y.abs) / 2
    end
  end
end
