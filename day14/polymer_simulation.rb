# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day14
  class PolymerSimulation < T::Struct
    extend T::Sig

    const :template, String
    const :rules, T::Hash[String, String]
    prop :partial_solutions, T::Hash[String, Integer], default: {}

    sig { params(input: String).returns(PolymerSimulation) }
    def self.build(input)
      template_part, rules_part = input.strip.split("\n\n")
      rules = T.must(rules_part).split("\n").each_with_object({}) do |line, acc|
        match, insert = line.strip.split(' -> ')
        acc[match] = insert
      end

      PolymerSimulation.new(
        template: T.must(template_part).strip,
        rules: rules
      )
    end

    sig { params(steps: Integer).returns(Integer) }
    def magic_result_after(steps) # rubocop:disable Metrics
      letters = rules.keys.join.chars.uniq

      results = letters.map do |letter|
        template.chars.count { |k| k == letter } +
          template.chars.each_cons(2).sum { |pair| count_letter(pair.join, steps, letter) }
      end

      T.must(results.max) - T.must(results.min)
    end

    private

    sig { params(pair: String, step: Integer, reference: String).returns(Integer) }
    def count_letter(pair, step, reference)
      return 0 if step.zero?

      left, right = pair.chars
      middle = rules[pair]

      partial_solutions[[left, right, step, reference].join(',')] ||=
        (middle == reference ? 1 : 0) +
        count_letter([left, middle].join, step - 1, reference) +
        count_letter([middle, right].join, step - 1, reference)
    end
  end
end
