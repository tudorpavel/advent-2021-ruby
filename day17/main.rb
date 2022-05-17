# typed: strict
# frozen_string_literal: true

require_relative './trick_shot'

input = ARGF.read

trick_shot = Day17::TrickShot.build(input)

puts "Part 1: #{trick_shot.part1_max_height}"
