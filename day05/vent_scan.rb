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
    def part1_point_count
      point_counts = Hash.new(0)
      point_counts = point_count_horizontal_and_vertical(point_counts)

      overlapping_point_count(point_counts)
    end

    sig { returns(Integer) }
    def part2_point_count
      point_counts = Hash.new(0)
      point_counts = point_count_horizontal_and_vertical(point_counts)
      point_counts = point_count_diagonal(point_counts)

      overlapping_point_count(point_counts)
    end

    private

    sig { params(point_counts: T::Hash[String, Integer]).returns(T::Hash[String, Integer]) }
    def point_count_horizontal_and_vertical(point_counts = Hash.new(0)) # rubocop:disable Metrics/AbcSize
      segments.filter(&:horizontal_or_vertical?).each do |segment|
        ([segment.start.x, segment.end.x].min..[segment.start.x, segment.end.x].max).each do |x|
          ([segment.start.y, segment.end.y].min..[segment.start.y, segment.end.y].max).each do |y|
            point_counts[[x, y].join(',')] += 1
          end
        end
      end

      point_counts
    end

    sig { params(point_counts: T::Hash[String, Integer]).returns(T::Hash[String, Integer]) }
    def point_count_diagonal(point_counts = Hash.new(0)) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      segments.reject(&:horizontal_or_vertical?).each do |segment|
        increment_x = segment.start.x < segment.end.x ? 1 : -1
        increment_y = segment.start.y < segment.end.y ? 1 : -1
        length = (segment.start.x - segment.end.x).abs
        current_x = segment.start.x
        current_y = segment.start.y

        (length + 1).times do
          point_counts[[current_x, current_y].join(',')] += 1
          current_x += increment_x
          current_y += increment_y
        end
      end

      point_counts
    end

    sig { params(point_counts: T::Hash[String, Integer]).returns(Integer) }
    def overlapping_point_count(point_counts)
      point_counts.values.filter { |c| c > 1 }.size
    end
  end
end
