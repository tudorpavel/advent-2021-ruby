# typed: false
# frozen_string_literal: true

require_relative '../../utils/parse_input'

RSpec.describe Utils::ParseInput do
  subject(:parse_input) { described_class.new }

  describe '#read_lines' do
    it 'strips trailing newlines from input lines', :aggregate_failures do
      expect(parse_input.read_lines(["abc\n"])).to eq(['abc'])
      expect(parse_input.read_lines(%W[abc\n def\n])).to eq(%w[abc def])
    end
  end
end
