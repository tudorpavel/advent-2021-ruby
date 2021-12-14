# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day14
  class PolymerSimulation < T::Struct
    extend T::Sig

    class Rule < T::Struct
      extend T::Sig

      const :match, String
      const :insert, String

      sig { params(line: String).returns(Rule) }
      def self.build(line)
        match, insert = line.strip.split(' -> ')

        Rule.new(match: T.must(match), insert: T.must(insert))
      end
    end

    const :template, String
    const :rules, T::Hash[String, String]

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

    sig { returns(Integer) }
    def part1_result_after_10_steps
      final_template = 10.times.reduce(template) { |t, _| step_simulation(t) }
      compute_magic_result(final_template)
    end

    private

    sig { params(template: String).returns(String) }
    def step_simulation(template)
      new_template = T.must(template[0])

      template.chars.each_cons(2) do |pair|
        new_template << rules[pair.join]
        new_template << pair[1]
      end

      new_template
    end

    sig { params(template: String).returns(Integer) }
    def compute_magic_result(template)
      occurrence_counts = template.chars.tally.values

      T.must(occurrence_counts.max) - T.must(occurrence_counts.min)
    end
  end
end
