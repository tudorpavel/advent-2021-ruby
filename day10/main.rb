# typed: strict
# frozen_string_literal: true

require_relative './nav_subsystem'

input = ARGF.read

nav_subsystem = Day10::NavSubsystem.build(input)

puts "Part 1: #{nav_subsystem.part1_syntax_error_score}"
