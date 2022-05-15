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
          patterns: T.must(left).split.map { |p| p.chars.sort.join },
          outputs: T.must(right).split.map { |p| p.chars.sort.join }
        )
      end

      # Unique digits:
      # ab      -> 1100000 (1)
      # dab     -> 1101000 (7)
      # eafb    -> 1100110 (4)
      # acedgfb -> 1111111 (8)

      # 6-segment digits:
      # cefabd -> 1111110 (9)
      # cdfgeb -> 0111111 (6)
      # cagedb -> 1111101 (0)
      #
      # Bitwise rules:
      #   - 9 AND 4 == 4
      #   - 6 OR 1 == 8
      #   - the other one is 0

      # 5-segment digits:
      # gcdfa   -> 1011011 (2)
      # fbcad   -> 1111010 (3)
      # cdfbe   -> 0111110 (5)
      #
      # Bitwise rules:
      #   - 3 OR 1 == 3
      #   - 5 OR 1 == 9
      #   - the other one is 2
      sig { returns(Integer) }
      def output_value # rubocop:disable Metrics/MethodLength, Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
        pattern_to_digit = {}
        digit_to_pattern = {}

        temp = patterns.dup

        # find easy patterns
        temp.each do |p|
          # rubocop:disable Style/CaseLikeIf
          if p.size == 2
            pattern_to_digit[p] = 1
            digit_to_pattern[1] = p
          elsif p.size == 3
            pattern_to_digit[p] = 7
            digit_to_pattern[7] = p
          elsif p.size == 4
            pattern_to_digit[p] = 4
            digit_to_pattern[4] = p
          elsif p.size == 7
            pattern_to_digit[p] = 8
            digit_to_pattern[8] = p
          end
          # rubocop:enable Style/CaseLikeIf
        end

        temp.reject! { |p| pattern_to_digit.keys.include?(p) }

        # find 9 and 6
        temp.each do |p|
          if p.size == 6 && pattern_to_binary(p) & pattern_to_binary(digit_to_pattern[4]) ==
                            pattern_to_binary(digit_to_pattern[4])
            pattern_to_digit[p] = 9
            digit_to_pattern[9] = p
          elsif p.size == 6 && pattern_to_binary(p) | pattern_to_binary(digit_to_pattern[1]) ==
                               pattern_to_binary(digit_to_pattern[8])
            pattern_to_digit[p] = 6
            digit_to_pattern[6] = p
          end
        end

        temp.reject! { |p| pattern_to_digit.keys.include?(p) }

        # find 0
        temp.each do |p|
          if p.size == 6
            pattern_to_digit[p] = 0
            digit_to_pattern[0] = p
          end
        end

        temp.reject! { |p| pattern_to_digit.keys.include?(p) }

        # find 3 and 5
        temp.each do |p|
          if p.size == 5 && pattern_to_binary(p) | pattern_to_binary(digit_to_pattern[1]) ==
                            pattern_to_binary(p)
            pattern_to_digit[p] = 3
            digit_to_pattern[3] = p
          elsif p.size == 5 && pattern_to_binary(p) | pattern_to_binary(digit_to_pattern[1]) ==
                               pattern_to_binary(digit_to_pattern[9])
            pattern_to_digit[p] = 5
            digit_to_pattern[5] = p
          end
        end

        temp.reject! { |p| pattern_to_digit.keys.include?(p) }

        # find 2
        temp.each do |p|
          if p.size == 5
            pattern_to_digit[p] = 2
            digit_to_pattern[2] = p
          end
        end

        outputs.map { |p| pattern_to_digit[p] }.join.to_i
      end

      private

      sig { params(pattern: String).returns(Integer) }
      def pattern_to_binary(pattern)
        'abcdefg'.chars.map { |c| pattern.include?(c) ? 1 : 0 }.join.to_i(2)
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

    sig { returns(Integer) }
    def part2_sum_output_values
      entries.map(&:output_value).sum
    end
  end
end
