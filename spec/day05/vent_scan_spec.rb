# typed: false
# frozen_string_literal: true

require_relative '../../day05/vent_scan'

RSpec.describe Day05::VentScan do
  subject(:vent_scan) do
    described_class.build(['0,9 -> 5,9',
                           '8,0 -> 0,8',
                           '9,4 -> 3,4',
                           '2,2 -> 2,1',
                           '7,0 -> 7,4',
                           '6,4 -> 2,0',
                           '0,9 -> 2,9',
                           '3,4 -> 1,4',
                           '0,0 -> 8,8',
                           '5,5 -> 8,2'])
  end

  describe '#part1_point_count' do
    it 'counts overlapping points for horizontal and vertical line segments' do
      expect(vent_scan.part1_point_count).to eq(5)
    end
  end
end
