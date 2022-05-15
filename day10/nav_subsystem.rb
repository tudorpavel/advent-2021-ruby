# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day10
  class NavSubsystem < T::Struct
    extend T::Sig

    ERROR_SCORES = T.let({ ')' => 3,
                           ']' => 57,
                           '}' => 1197,
                           '>' => 25_137 }, T::Hash[String, Integer])
    COMPLETION_SCORES = T.let({ '(' => 1,
                                '[' => 2,
                                '{' => 3,
                                '<' => 4 }, T::Hash[String, Integer])
    PARENS = T.let({ '(' => ')',
                     '[' => ']',
                     '{' => '}',
                     '<' => '>' }, T::Hash[T.nilable(String), String])
    OPEN_PARENS = T.let(PARENS.keys, T::Array[T.nilable(String)])
    CLOSE_PARENS = T.let(PARENS.values, T::Array[String])

    const :lines, T::Array[String]

    sig { params(input: String).returns(NavSubsystem) }
    def self.build(input)
      NavSubsystem.new(
        lines: input.strip.split("\n").map(&:strip)
      )
    end

    sig { returns(Integer) }
    def part1_syntax_error_score
      lines.map { |line| syntax_score(line) }.sum
    end

    sig { returns(Integer) }
    def part2_middle_completion_score
      temp = lines.dup
      temp.reject! { |line| syntax_score(line).positive? }

      T.must(temp.map { |line| completion_score(line) }.sort[temp.size / 2])
    end

    private

    sig { params(line: String).returns(Integer) }
    def syntax_score(line)
      stack = []

      line.each_char do |c|
        if OPEN_PARENS.include?(c)
          stack << c
        elsif CLOSE_PARENS.include?(c)
          c == PARENS[stack.last] ? stack.pop : (return T.must(ERROR_SCORES[c]))
        end
      end

      0
    end

    sig { params(line: String).returns(Integer) }
    def completion_score(line) # rubocop:disable Metrics/MethodLength
      stack = []

      line.each_char do |c|
        if OPEN_PARENS.include?(c)
          stack << c
        elsif CLOSE_PARENS.include?(c)
          stack.pop if c == PARENS[stack.last]
        end
      end

      score = 0

      while stack.size.positive?
        paren = stack.pop
        score = (score * 5) + T.must(COMPLETION_SCORES[paren])
      end

      score
    end
  end
end
