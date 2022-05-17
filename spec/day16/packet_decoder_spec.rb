# typed: false
# frozen_string_literal: true

require_relative '../../day16/packet_decoder'

RSpec.describe Day16::PacketDecoder do
  describe '#part1_sum_all_versions' do
    it 'works for base cases', :aggregate_failures do
      expect(described_class.build('D2FE28').part1_sum_all_versions).to eq(6)
      expect(described_class.build('38006F45291200').part1_sum_all_versions).to eq(9)
      expect(described_class.build('EE00D40C823060').part1_sum_all_versions).to eq(14)
    end

    it 'decodes all nested packets and sums up their versions', :aggregate_failures do
      expect(described_class.build('8A004A801A8002F478').part1_sum_all_versions).to eq(16)
      expect(described_class.build('620080001611562C8802118E34').part1_sum_all_versions).to eq(12)
      expect(described_class.build('C0015000016115A2E0802F182340').part1_sum_all_versions).to eq(23)
      expect(described_class.build('A0016C880162017C3686B18A3D4780').part1_sum_all_versions).to eq(31)
    end
  end
end
