# typed: strict
# frozen_string_literal: true

require_relative './school'

input = ARGF.read

school = Day06::School.build(input)

puts "Part 1: #{school.fish_count_after(80)}"
puts "Part 2: #{school.fish_count_after(256)}"
