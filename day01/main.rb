# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../utils/parse_input'
require_relative './sonar'

lines = Utils::ParseInput.new.read_lines(ARGF.readlines)

sonar = Day01::Sonar.build(lines)

puts "Part1: #{sonar.increase_count_part1}"
puts "Part2: #{sonar.increase_count_part2}"
