# typed: false
# frozen_string_literal: true

require_relative '../../day12/cave_system'

RSpec.describe Day12::CaveSystem do
  subject(:cave_system) do
    described_class.build(%(
      fs-end
      he-DX
      fs-he
      start-DX
      pj-DX
      end-zg
      zg-sl
      zg-pj
      pj-he
      RW-he
      fs-DX
      pj-RW
      zg-RW
      start-pj
      he-WI
      zg-he
      pj-fs
      start-RW
    ))
  end

  describe '#part1_path_count' do
    it 'counts paths visiting small caves at most once' do
      expect(cave_system.part1_path_count).to eq(226)
    end
  end

  describe '#part2_path_count' do
    it 'counts paths visiting a small cave at most twice and the other small caves at most once' do
      expect(cave_system.part2_path_count).to eq(3509)
    end
  end
end
