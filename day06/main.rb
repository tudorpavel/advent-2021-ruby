# typed: strict
# frozen_string_literal: true

require_relative './school'

input = ARGF.read

school = Day06::School.build(input)

puts "Part 1: #{school.part1_fish_count_after_80_days}"
