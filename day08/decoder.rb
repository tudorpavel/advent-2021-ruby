# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day08
  class Decoder < T::Struct
    extend T::Sig

    UNIQUE_SEGMENT_COUNTS = T.let([2, 3, 4, 7], T::Array[Integer])

    class Entry < T::Struct
      extend T::Sig

      const :patterns, T::Array[String]
      const :outputs, T::Array[String]

      sig { params(line: String).returns(Entry) }
      def self.build(line)
        left, right = line.split(' | ')

        Entry.new(
          patterns: T.must(left).split,
          outputs: T.must(right).split
        )
      end
    end

    const :entries, T::Array[Entry]

    sig { params(input: String).returns(Decoder) }
    def self.build(input)
      Decoder.new(
        entries: input.strip.split("\n").map { |line| Entry.build(line) }
      )
    end

    sig { returns(Integer) }
    def part1_easy_digit_count
      result = 0

      entries.each do |entry|
        entry.outputs.each do |output|
          result += 1 if UNIQUE_SEGMENT_COUNTS.include?(output.size)
        end
      end

      result
    end
  end
end
