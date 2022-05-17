# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day16
  class PacketDecoder < T::Struct
    extend T::Sig

    class Packet < T::Struct
      extend T::Sig

      const :version, Integer
      const :type_id, Integer
    end

    const :bit_string, String

    sig { params(input: String).returns(PacketDecoder) }
    def self.build(input)
      input = input.strip
      PacketDecoder.new(bit_string: input.to_i(16).to_s(2).rjust(input.size * 4, '0'))
    end

    sig { returns(Integer) }
    def part1_sum_all_versions
      _offset, sum = sum_versions(0)

      T.must(sum)
    end

    private

    sig { params(offset: Integer).returns(T::Array[Integer]) }
    def sum_versions(offset) # rubocop:disable Metrics
      version = T.must(bit_string[offset..offset + 2]).to_i(2) # as decimal
      packet_type = bit_string[offset + 3..offset + 5]
      new_offset = offset
      sum = version

      if packet_type == '100' # packet is a literal value
        oo, _value = literal_value(offset + 6)
        new_offset = T.must(oo)
      else
        length_type = bit_string[offset + 6]

        if length_type == '0' # length is bit count
          length = T.must(bit_string[offset + 7..offset + 21]).to_i(2)
          new_offset = offset + 22
          target_offset = new_offset + length

          while new_offset < target_offset
            o, s = sum_versions(new_offset)
            new_offset = T.must(o)
            sum += T.must(s)
          end
        else # length is packet count
          length = T.must(bit_string[offset + 7..offset + 17]).to_i(2)
          new_offset = offset + 18

          length.times do
            o, s = sum_versions(new_offset)
            new_offset = T.must(o)
            sum += T.must(s)
          end
        end
      end

      [new_offset, sum]
    end

    sig { params(offset: Integer).returns(T::Array[Integer]) }
    def literal_value(offset)
      new_offset = offset
      value = ''

      loop do
        check_bit = bit_string[new_offset]
        value += T.must(bit_string[new_offset + 1..new_offset + 4])
        new_offset += 5

        break if check_bit == '0'
      end

      [new_offset, value.to_i(2)]
    end
  end
end
