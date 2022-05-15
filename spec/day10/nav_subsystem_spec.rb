# typed: false
# frozen_string_literal: true

require_relative '../../day10/nav_subsystem'

RSpec.describe Day10::NavSubsystem do
  subject(:nav_subsystem) do
    described_class.build(
      <<-INPUT
        [({(<(())[]>[[{[]{<()<>>
        [(()[<>])]({[<{<<[]>>(
        {([(<{}[<>[]}>{[]{[(<()>
        (((({<>}<{<{<>}{[]{[]{}
        [[<[([]))<([[{}[[()]]]
        [{[{({}]{}}([{[{{{}}([]
        {<[[]]>}<{[{[{[]{()[[[]
        [<(<(<(<{}))><([]([]()
        <{([([[(<>()){}]>(<<{{
        <{([{{}}[<[[[<>{}]]]>[]]
      INPUT
    )
  end

  describe '#part1_syntax_error_score' do
    it 'calculates total syntax error score for corrupted lines' do
      expect(nav_subsystem.part1_syntax_error_score).to eq(26_397)
    end
  end

  describe '#part2_middle_completion_score' do
    it 'computes completion scores for incomplete lines and returns the middle score' do
      expect(nav_subsystem.part2_middle_completion_score).to eq(288_957)
    end
  end
end
