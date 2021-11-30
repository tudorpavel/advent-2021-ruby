# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Utils
  class ParseInput
    extend T::Sig

    sig { params(input_lines: T::Array[String]).returns(T::Array[String]) }
    def read_lines(input_lines)
      input_lines.map(&:strip)
    end
  end
end
