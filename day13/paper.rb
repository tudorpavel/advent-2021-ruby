# typed: strict
# frozen_string_literal: true

require 'set'
require 'sorbet-runtime'

require_relative './dot'

module Day13
  class Paper < T::Struct
    extend T::Sig

    class FoldDirection < T::Enum
      enums do
        Up = new
        Left = new
      end
    end

    class Fold < T::Struct
      extend T::Sig

      const :direction, FoldDirection
      const :value, Integer

      sig { params(line: String).returns(Fold) }
      def self.build(line)
        direction_part, value_str = line.split('=')
        Fold.new(
          direction: T.must(direction_part)[-1] == 'x' ? FoldDirection::Left : FoldDirection::Up,
          value: value_str.to_i
        )
      end
    end

    const :dots, T::Set[Dot]
    const :folds, T::Array[Fold]

    sig { params(input: String).returns(Paper) }
    def self.build(input)
      dots_part, folds_part = input.strip.split("\n\n")

      Paper.new(
        dots: Set.new(T.must(dots_part).split("\n").map { |line| Dot.build(line) }),
        folds: T.must(folds_part).split("\n").map { |line| Fold.build(line) }
      )
    end

    sig { returns(Integer) }
    def part1_dots_count
      new_dots = fold_once(dots, T.must(folds[0]))

      new_dots.size
    end

    sig { void }
    def part2_print_folded_paper
      pretty_print(
        folds.reduce(dots) { |dots, fold| fold_once(dots, fold) }
      )
    end

    private

    sig { params(dots: T::Set[Dot], fold: Fold).returns(T::Set[Dot]) }
    def fold_once(dots, fold) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      new_dots = Set.new
      direction = fold.direction

      dots.each do |dot|
        case direction
        when FoldDirection::Up
          new_dots.add(
            Dot.new(x: dot.x, y: fold.value < dot.y ? fold.value - (dot.y - fold.value) : dot.y)
          )
        when FoldDirection::Left
          new_dots.add(
            Dot.new(y: dot.y, x: fold.value < dot.x ? fold.value - (dot.x - fold.value) : dot.x)
          )
        else T.absurd(direction)
        end
      end

      new_dots
    end

    sig { params(dots: T::Set[Dot]).void }
    def pretty_print(dots)
      (0..(dots.map(&:y).max)).each do |y|
        (0..(dots.map(&:x).max)).each do |x|
          print dots.include?(Dot.new(x: x, y: y)) ? '▇' : ' '
        end

        puts
      end
    end
  end
end
