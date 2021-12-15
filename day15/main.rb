# typed: strict
# frozen_string_literal: true

require_relative './cavern'

input = ARGF.read

cavern = Day15::Cavern.build(input)

puts "Part 1: #{cavern.part1_lowest_total_risk}"
puts "Part 2: #{cavern.part2_lowest_total_risk}"
