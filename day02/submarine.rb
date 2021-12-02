# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative './command'

module Day02
  class Submarine < T::Struct
    extend T::Sig

    const :commands, T::Array[Command]

    sig { params(lines: T::Array[String]).returns(Submarine) }
    def self.build(lines)
      Submarine.new(commands: lines.map { |l| Command.build(l) })
    end

    sig { returns(Integer) }
    def execute_part1 # rubocop:disable Metrics/MethodLength
      horizontal = 0
      depth = 0

      commands.each do |c|
        op = c.op
        case op
        when Command::Op::Forward then horizontal += c.x
        when Command::Op::Down then depth += c.x
        when Command::Op::Up then depth -= c.x
        else T.absurd(op)
        end
      end

      horizontal * depth
    end

    sig { returns(Integer) }
    def execute_part2 # rubocop:disable Metrics/MethodLength
      horizontal = 0
      depth = 0
      aim = 0

      commands.each do |c|
        op = c.op
        case op
        when Command::Op::Forward
          horizontal += c.x
          depth += aim * c.x
        when Command::Op::Down then aim += c.x
        when Command::Op::Up then aim -= c.x
        else T.absurd(op)
        end
      end

      horizontal * depth
    end
  end
end
