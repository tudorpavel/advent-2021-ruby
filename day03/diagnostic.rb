# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day03
  class Diagnostic < T::Struct
    extend T::Sig

    sig { params(report: T::Array[String]).returns(Integer) }
    def power_consumption(report) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      gamma_rate = []
      epsilon_rate = []

      (0..(T.must(report.first).size - 1)).each do |i|
        tally = report.map { |n| n[i] }.tally
        count0 = tally['0'] || 0
        count1 = tally['1'] || 0

        if count0 > count1
          gamma_rate << '0'
          epsilon_rate << '1'
        else
          gamma_rate << '1'
          epsilon_rate << '0'
        end
      end

      gamma_rate = gamma_rate.join.to_i(2)
      epsilon_rate = epsilon_rate.join.to_i(2)

      gamma_rate * epsilon_rate
    end

    sig { params(report: T::Array[String]).returns(Integer) }
    def life_support_rating(report)
      oxygen_rating = generic_rating(report, '0')
      co2_rating = generic_rating(report, '1')

      oxygen_rating * co2_rating
    end

    private

    sig { params(report: T::Array[String], main_bit: String).returns(Integer) }
    def generic_rating(report, main_bit) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      nums = report.dup
      size = T.must(nums.first).size
      other_bit = main_bit == '0' ? '1' : '0'

      (0..(size - 1)).each do |i|
        tally = nums.map { |n| n[i] }.tally
        count0 = tally['0'] || 0
        count1 = tally['1'] || 0

        nums = nums.filter { |n| n[i] == (count0 > count1 ? main_bit : other_bit) }

        return T.must(nums.first).to_i(2) if nums.size == 1
      end

      raise ArgumentError, 'Did not find just 1 remaining number'
    end
  end
end
