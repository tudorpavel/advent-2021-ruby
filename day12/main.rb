# typed: strict
# frozen_string_literal: true

require_relative './cave_system'

input = ARGF.read

cave_system = Day12::CaveSystem.build(input)

puts "Part 1: #{cave_system.part1_path_count}"
