# typed: false
# frozen_string_literal: true

require_relative '../../day06/school'

RSpec.describe Day06::School do
  subject(:school) { described_class.build('3,4,3,1,2') }

  describe '#fish_count_after' do
    it 'returns correct result for 80 days' do
      expect(school.fish_count_after(80)).to eq(5934)
    end

    it 'returns correct result for 256 days' do
      expect(school.fish_count_after(256)).to eq(26_984_457_539)
    end
  end
end
