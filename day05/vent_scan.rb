# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

require_relative './line_segment'

module Day05
  # Compute helpful stuff about a set of vents
  class VentScan < T::Struct
    extend T::Sig

    const :segments, T::Array[LineSegment]

    sig { params(lines: T::Array[String]).returns(VentScan) }
    def self.build(lines)
      VentScan.new(segments: lines.map { |line| LineSegment.build(line) })
    end

    sig { returns(Integer) }
    def part1_point_count # rubocop:disable Metrics/AbcSize
      point_counts = Hash.new(0)

      segments.filter(&:horizontal_or_vertical?).each do |segment|
        ([segment.start.x, segment.end.x].min..[segment.start.x, segment.end.x].max).each do |x|
          ([segment.start.y, segment.end.y].min..[segment.start.y, segment.end.y].max).each do |y|
            point_counts[[x, y].join(',')] += 1
          end
        end
      end

      point_counts.values.filter { |c| c > 1 }.size
    end
  end
end
