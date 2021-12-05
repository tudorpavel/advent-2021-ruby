# typed: false
# frozen_string_literal: true

require_relative '../../day05/line_segment'

RSpec.describe Day05::LineSegment do
  describe '.build' do
    it 'initializes segment correctly', :aggregate_failures do
      segment = described_class.build('6,4 -> 2,0')

      expect(segment.start.x).to eq(6)
      expect(segment.start.y).to eq(4)
      expect(segment.end.x).to eq(2)
      expect(segment.end.y).to eq(0)
    end
  end

  describe '#horizontal_or_vertical?' do
    it 'returns correct values for some example segments', :aggregate_failures do
      expect(described_class.build('0,9 -> 5,9').horizontal_or_vertical?).to eq(true)
      expect(described_class.build('2,2 -> 2,1').horizontal_or_vertical?).to eq(true)
      expect(described_class.build('6,4 -> 2,0').horizontal_or_vertical?).to eq(false)
    end
  end
end
