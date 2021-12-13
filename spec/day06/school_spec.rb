# typed: false
# frozen_string_literal: true

require_relative '../../day06/school'

RSpec.describe Day06::School do
  subject(:school) { described_class.build('3,4,3,1,2') }

  describe '#part1_fish_count_after_80_days' do
    it 'runs simulation for 80 days and counts the resulting fish' do
      expect(school.part1_fish_count_after_80_days).to eq(5934)
    end
  end
end
