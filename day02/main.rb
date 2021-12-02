# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../utils/parse_input'
require_relative './submarine'

lines = Utils::ParseInput.new.read_lines(ARGF.readlines)

submarine = Day02::Submarine.build(lines)

puts "Part1: #{submarine.execute_part1}"
puts "Part2: #{submarine.execute_part2}"
