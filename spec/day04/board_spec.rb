# typed: false
# frozen_string_literal: true

require_relative '../../day04/board'

RSpec.describe Day04::Board do
  subject(:board) do
    described_class.build(['14 21 17 24 4',
                           '10 16 15 9 19',
                           '18 8 23 26 20',
                           '22 11 13 6 5',
                           '2 0 12 3 7'])
  end

  describe '#line_win?' do
    it 'confirms win after a few numbers are drawn' do
      nums = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24]
      nums.each { |n| board.mark_number(n) }

      expect(board.line_win?).to eq(true)
    end
  end

  describe '#score' do
    it 'calculates the right score after a win' do
      nums = [7, 4, 9, 5, 11, 17, 23, 2, 0, 14, 21, 24]
      nums.each { |n| board.mark_number(n) }

      expect(board.score).to eq(4512)
    end
  end
end
