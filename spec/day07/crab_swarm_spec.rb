# typed: false
# frozen_string_literal: true

require_relative '../../day07/crab_swarm'

RSpec.describe Day07::CrabSwarm do
  subject(:swarm) { described_class.build('16,1,2,0,4,2,7,1,2,14') }

  describe '#part1_minimum_fuel_cost' do
    it 'finds the cheapest possible position and returns its cost' do
      expect(swarm.part1_minimum_fuel_cost).to eq(37)
    end
  end

  describe '#part2_minimum_fuel_cost' do
    it 'finds the cheapest possible position with new fuel burn rate rule' do
      expect(swarm.part2_minimum_fuel_cost).to eq(168)
    end
  end
end
