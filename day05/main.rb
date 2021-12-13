# typed: strict
# frozen_string_literal: true

require_relative './vent_scan'

lines = ARGF.readlines.map(&:strip)

vent_scan = Day05::VentScan.build(lines)

puts "Part 1: #{vent_scan.part1_point_count}"
puts "Part 2: #{vent_scan.part2_point_count}"
