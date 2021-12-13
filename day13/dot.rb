# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day13
  class Dot < T::Struct
    extend T::Sig

    const :x, Integer
    const :y, Integer

    sig { params(line: String).returns(Dot) }
    def self.build(line)
      x_str, y_str = line.split(',')

      Dot.new(x: x_str.to_i, y: y_str.to_i)
    end

    sig { params(other: Dot).returns(T::Boolean) }
    def eql?(other)
      [x, y] == [other.x, other.y]
    end

    sig { returns(Integer) }
    def hash
      [x, y].hash
    end
  end
end
