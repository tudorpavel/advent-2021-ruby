# typed: false
# frozen_string_literal: true

require_relative '../../day13/paper'

RSpec.describe Day13::Paper do
  subject(:paper) do
    described_class.build(%(
      6,10
      0,14
      9,10
      0,3
      10,4
      4,11
      6,0
      6,12
      4,1
      0,13
      10,12
      3,4
      3,0
      8,4
      1,10
      2,14
      8,10
      9,0

      fold along y=7
      fold along x=5
    ))
  end

  describe '#part1_dots_count' do
    it 'counts the visible dots after completing the first fold' do
      expect(paper.part1_dots_count).to eq(17)
    end
  end
end
