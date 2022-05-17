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

  describe '#part2_expression_result' do
    it 'decodes and evaluates expression represented by the packets', :aggregate_failures do
      expect(described_class.build('C200B40A82').part2_expression_result).to eq(3) # sum
      expect(described_class.build('04005AC33890').part2_expression_result).to eq(54) # product
      expect(described_class.build('880086C3E88112').part2_expression_result).to eq(7) # minimum
      expect(described_class.build('CE00C43D881120').part2_expression_result).to eq(9) # maximum
    end

    it 'works with comparison operators', :aggregate_failures do
      expect(described_class.build('D8005AC2A8F0').part2_expression_result).to eq(1) # less than
      expect(described_class.build('F600BC2D8F').part2_expression_result).to eq(0) # greater than
      expect(described_class.build('9C005AC2F8F0').part2_expression_result).to eq(0) # equal
      expect(described_class.build('9C0141080250320F1802104A08').part2_expression_result).to eq(1) # combined exp
    end
  end
end
