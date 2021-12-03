# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../utils/parse_input'
require_relative './diagnostic'

lines = Utils::ParseInput.new.read_lines(ARGF.readlines)

diagnostic = Day03::Diagnostic.new

puts "Part1: #{diagnostic.power_consumption(lines)}"
puts "Part2: #{diagnostic.life_support_rating(lines)}"
