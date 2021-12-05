# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day05
  # A vent line segment between two points
  class LineSegment < T::Struct
    extend T::Sig

    class Point < T::Struct
      const :x, Integer
      const :y, Integer
    end

    const :start, Point
    const :end, Point

    sig { params(line: String).returns(LineSegment) }
    def self.build(line)
      start_part, end_part = line.split(' -> ')
      start_x, start_y = T.must(start_part).split(',').map(&:to_i)
      end_x, end_y = T.must(end_part).split(',').map(&:to_i)

      LineSegment.new(
        start: Point.new(x: T.must(start_x), y: T.must(start_y)),
        end: Point.new(x: T.must(end_x), y: T.must(end_y))
      )
    end

    sig { returns(T::Boolean) }
    def horizontal_or_vertical?
      @start.x == @end.x || @start.y == @end.y
    end
  end
end
