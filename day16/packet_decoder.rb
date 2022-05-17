# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day16
  class PacketDecoder < T::Struct # rubocop:disable Metrics/ClassLength
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

    sig { returns(Integer) }
    def part2_expression_result
      _offset, result = eval_packet(0)

      T.must(result)
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

    sig { params(offset: Integer).returns(T::Array[Integer]) }
    def eval_packet(offset) # rubocop:disable Metrics
      packet_type = T.must(bit_string[offset + 3..offset + 5]).to_i(2) # as decimal
      new_offset = offset
      operands = []

      if packet_type == 4 # packet is a literal value
        oo, value = literal_value(offset + 6)
        new_offset = T.must(oo)
        operands << value
      else
        length_type = bit_string[offset + 6]

        if length_type == '0' # length is bit count
          length = T.must(bit_string[offset + 7..offset + 21]).to_i(2)
          new_offset = offset + 22
          target_offset = new_offset + length

          while new_offset < target_offset
            o, r = eval_packet(new_offset)
            new_offset = T.must(o)
            operands << T.must(r)
          end
        else # length is packet count
          length = T.must(bit_string[offset + 7..offset + 17]).to_i(2)
          new_offset = offset + 18

          length.times do
            o, r = eval_packet(new_offset)
            new_offset = T.must(o)
            operands << T.must(r)
          end
        end
      end

      [new_offset, compute_result(packet_type, operands)]
    end

    sig { params(operator: Integer, operands: T::Array[Integer]).returns(Integer) }
    def compute_result(operator, operands) # rubocop:disable Metrics
      case operator
      when 0 # sum
        operands.sum
      when 1 # product
        operands.reduce(&:*)
      when 2 # minimum
        operands.min
      when 3 # maximum
        operands.max
      when 4 # literal
        T.must(operands.first)
      when 5 # greater than
        a, b = operands
        T.must(a) > T.must(b) ? 1 : 0
      when 6 # less than
        a, b = operands
        T.must(a) < T.must(b) ? 1 : 0
      when 7 # equal
        a, b = operands
        T.must(a) == T.must(b) ? 1 : 0
      else
        raise ArgumentError, "Unknown operator=#{operator}"
      end
    end
  end
end
