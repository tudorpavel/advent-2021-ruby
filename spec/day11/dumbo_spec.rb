# typed: false
# frozen_string_literal: true

require_relative '../../day11/dumbo'

RSpec.describe Day11::Dumbo do
  subject(:dumbo) do
    described_class.build(%(
      5483143223
      2745854711
      5264556173
      6141336146
      6357385478
      4167524645
      2176841721
      6882881134
      4846848554
      5283751526
    ))
  end

  describe '#part1_flash_count' do
    it 'simulates for 100 steps and counts flashes that happen in that time' do
      expect(dumbo.part1_flash_count).to eq(1656)
    end
  end
end
