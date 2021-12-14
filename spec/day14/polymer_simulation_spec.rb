# typed: false
# frozen_string_literal: true

require_relative '../../day14/polymer_simulation'

RSpec.describe Day14::PolymerSimulation do
  subject(:polymer_simulation) do
    described_class.build(%(
      NNCB

      CH -> B
      HH -> N
      CB -> H
      NH -> C
      HB -> C
      HC -> B
      HN -> C
      NN -> C
      BH -> H
      NC -> B
      NB -> B
      BN -> B
      BB -> N
      BC -> B
      CC -> N
      CN -> C
    ))
  end

  describe '#part1_result_after_10_steps' do
    it 'runs polymer simulation for 10 steps and returns the magic result' do
      expect(polymer_simulation.part1_result_after_10_steps).to eq(1588)
    end
  end
end
