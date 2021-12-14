# typed: strict
# frozen_string_literal: true

input = ARGF.read.strip

nums = input.split(',').map(&:to_i).sort

raise ArgumentError, 'input is not an even number of integers' if nums.size.odd?
raise ArgumentError, 'median numbers are not equal' if nums[nums.size / 2] != nums[(nums.size / 2) - 1]

median = nums[nums.size / 2]
total_cost = nums.map { |n| (n - median).abs }.sum

puts "Part 1: #{total_cost}"
