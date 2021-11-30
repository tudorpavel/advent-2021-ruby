# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative '../utils/parse_input'

lines = Utils::ParseInput.new.read_lines(ARGF.readlines)

one_line_input = T.must(lines[0])
puts "Part1: #{one_line_input}"
puts "Part2: #{one_line_input}"
