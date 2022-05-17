# typed: false
# frozen_string_literal: true

require_relative '../../day17/trick_shot'

RSpec.describe Day17::TrickShot do
  subject(:trick_shot) do
    described_class.build(%(
      target area: x=20..30, y=-10..-5
    ))
  end

  describe '#part1_max_height' do
    it 'finds heighest y position reachable while still making the target' do
      expect(trick_shot.part1_max_height).to eq(45)
    end
  end
end
