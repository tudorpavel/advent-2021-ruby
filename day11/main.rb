# typed: strict
# frozen_string_literal: true

require_relative './dumbo'

input = ARGF.read

dumbo = Day11::Dumbo.build(input)

puts "Part 1: #{dumbo.part1_flash_count}"
puts "Part 2: #{dumbo.part2_all_flash_step}"
