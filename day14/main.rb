# typed: strict
# frozen_string_literal: true

require_relative './polymer_simulation'

input = ARGF.read

polymer_simulation = Day14::PolymerSimulation.build(input)

puts "Part 1: #{polymer_simulation.part1_result_after_10_steps}"
