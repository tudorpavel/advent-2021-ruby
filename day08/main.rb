# typed: strict
# frozen_string_literal: true

require_relative './decoder'

input = ARGF.read

decoder = Day08::Decoder.build(input)

puts "Part 1: #{decoder.part1_easy_digit_count}"
puts "Part 2: #{decoder.part2_sum_output_values}"
