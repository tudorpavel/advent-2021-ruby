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

  describe '#magic_result_after' do
    it 'computes magic result for 10 steps and 40 steps', :aggregate_failures do
      expect(polymer_simulation.magic_result_after(10)).to eq(1588)
      expect(polymer_simulation.magic_result_after(40)).to eq(2_188_189_693_529)
    end
  end
end
