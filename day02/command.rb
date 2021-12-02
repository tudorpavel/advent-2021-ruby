# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day02
  class Command < T::Struct
    extend T::Sig

    class Op < T::Enum
      enums do
        Forward = new
        Down = new
        Up = new
      end
    end

    const :op, Op
    const :x, Integer

    sig { params(line: String).returns(Command) }
    def self.build(line)
      op, x = line.split
      op = case op
           when 'forward' then Op::Forward
           when 'down' then Op::Down
           when 'up' then Op::Up
           else raise ArgumentError, "Unexpected op #{op}"
           end

      Command.new(op: op, x: x.to_i)
    end
  end
end
