# typed: false
# frozen_string_literal: true

require_relative '../../day15/cavern'

RSpec.describe Day15::Cavern do
  subject(:cavern) do
    described_class.build(%(
      1163751742
      1381373672
      2136511328
      3694931569
      7463417111
      1319128137
      1359912421
      3125421639
      1293138521
      2311944581
    ))
  end

  describe '#part1_lowest_total_risk' do
    it 'finds cheapest path and returns total risk' do
      expect(cavern.part1_lowest_total_risk).to eq(40)
    end
  end
end
