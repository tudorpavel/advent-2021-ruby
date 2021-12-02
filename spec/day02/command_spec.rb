# typed: false
# frozen_string_literal: true

require_relative '../../day02/command'

RSpec.describe Day02::Command do
  describe '.build', :aggregate_failures do
    it 'parses `forward` commands correctly' do
      command = described_class.build('forward 5')
      expect(command.op).to eq(Day02::Command::Op::Forward)
      expect(command.x).to eq(5)
    end

    it 'parses `down` commands correctly' do
      command = described_class.build('down 12')
      expect(command.op).to eq(Day02::Command::Op::Down)
      expect(command.x).to eq(12)
    end

    it 'parses `up` commands correctly' do
      command = described_class.build('up 3')
      expect(command.op).to eq(Day02::Command::Op::Up)
      expect(command.x).to eq(3)
    end
  end
end
