# typed: false
# frozen_string_literal: true

require_relative '../../day01/sonar'

RSpec.describe Day01::Sonar do
  describe '.build' do
    it 'parses measurements correctly' do
      sonar = described_class.build(%w[1 2 3])

      expect(sonar.measurements).to eq([1, 2, 3])
    end
  end

  describe '#increase_count_part1' do
    it 'counts measurement increases' do
      sonar = described_class.build(%w[199 200 208 210 200 207 240 269 260 263])

      expect(sonar.increase_count_part1).to eq(7)
    end
  end

  describe '#increase_count_part2' do
    it 'counts measurement increase with sliding window of 3' do
      sonar = described_class.build(%w[199 200 208 210 200 207 240 269 260 263])

      expect(sonar.increase_count_part2).to eq(5)
    end
  end
end
