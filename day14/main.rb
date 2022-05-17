# typed: strict
# frozen_string_literal: true

require_relative './polymer_simulation'

input = ARGF.read

polymer_simulation = Day14::PolymerSimulation.build(input)

puts "Part 1: #{polymer_simulation.magic_result_after(10)}"
puts "Part 2: #{polymer_simulation.magic_result_after(40)}"
