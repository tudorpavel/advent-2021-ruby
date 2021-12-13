# typed: strict
# frozen_string_literal: true

require_relative './paper'

input = ARGF.read

paper = Day13::Paper.build(input)

puts "Part 1: #{paper.part1_dots_count}"
