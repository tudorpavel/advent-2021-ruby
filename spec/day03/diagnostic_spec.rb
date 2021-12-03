# typed: false
# frozen_string_literal: true

require_relative '../../day03/diagnostic'

RSpec.describe Day03::Diagnostic do
  subject(:diagnostic) { described_class.new }

  describe '#power_consumption' do
    it 'calculates power consumption based on report' do
      power = diagnostic.power_consumption(%w[00100 11110 10110 10111 10101 01111
                                              00111 11100 10000 11001 00010 01010])

      expect(power).to eq(198)
    end
  end

  describe '#life_support_rating' do
    it 'calculates life support rating based on report' do
      rating = diagnostic.life_support_rating(%w[00100 11110 10110 10111 10101 01111
                                                 00111 11100 10000 11001 00010 01010])

      expect(rating).to eq(230)
    end
  end
end
