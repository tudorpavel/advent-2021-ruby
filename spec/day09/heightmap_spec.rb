# typed: false
# frozen_string_literal: true

require_relative '../../day09/heightmap'

RSpec.describe Day09::Heightmap do
  subject(:heightmap) do
    described_class.build(%(
      2199943210
      3987894921
      9856789892
      8767896789
      9899965678
    ))
  end

  describe '#part1_risk_level_sum' do
    it 'finds all low points and sums up their risk levels' do
      expect(heightmap.part1_risk_level_sum).to eq(15)
    end
  end

  describe '#part2_product_three_largest_basins' do
    it 'computes size for all basins and returns the product of the 3 largest ones' do
      expect(heightmap.part2_product_three_largest_basins).to eq(1134)
    end
  end
end
