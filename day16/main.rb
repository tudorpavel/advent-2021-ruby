# typed: strict
# frozen_string_literal: true

require_relative './packet_decoder'

input = ARGF.read

packet_decoder = Day16::PacketDecoder.build(input)

puts "Part 1: #{packet_decoder.part1_sum_all_versions}"
puts "Part 2: #{packet_decoder.part2_expression_result}"
