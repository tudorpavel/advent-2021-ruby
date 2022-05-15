# typed: strict
# frozen_string_literal: true

require_relative './heightmap'

input = ARGF.read

heightmap = Day09::Heightmap.build(input)

puts "Part 1: #{heightmap.part1_risk_level_sum}"
puts "Part 2: #{heightmap.part2_product_three_largest_basins}"
