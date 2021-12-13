# typed: false
# frozen_string_literal: true

require_relative '../../day13/dot'

RSpec.describe Day13::Dot do
  describe '.build' do
    it 'initializes dot correctly', :aggregate_failures do
      dot = described_class.build('6,4')

      expect(dot.x).to eq(6)
      expect(dot.y).to eq(4)
    end
  end

  describe 'comparable' do
    it 'can be used in a Set' do
      d1 = described_class.build('1,2')
      d2 = described_class.build('1,2')

      set = Set[d1, d2]
      expect(set.size).to eq(1)
    end
  end
end
