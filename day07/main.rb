# typed: strict
# frozen_string_literal: true

require_relative './crab_swarm'

input = ARGF.read

swarm = Day07::CrabSwarm.build(input)

puts "Part 1: #{swarm.part1_minimum_fuel_cost}"
puts "Part 2: #{swarm.part2_minimum_fuel_cost}"
