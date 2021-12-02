# typed: false
# frozen_string_literal: true

require_relative '../../day02/submarine'

RSpec.describe Day02::Submarine do
  subject(:submarine) do
    described_class.build(['forward 5',
                           'down 5',
                           'forward 8',
                           'up 3',
                           'down 8',
                           'forward 2'])
  end

  describe '#execute_part1' do
    it 'returns the right answer' do
      expect(submarine.execute_part1).to eq(150)
    end
  end

  describe '#execute_part2' do
    it 'returns the right answer' do
      expect(submarine.execute_part2).to eq(900)
    end
  end
end
