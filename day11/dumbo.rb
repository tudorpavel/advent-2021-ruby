# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'

module Day11
  class Dumbo < T::Struct
    extend T::Sig

    Grid = T.type_alias { T::Array[T::Array[Integer]] }

    DELTAS = T.let([[-1, -1], [-1, 0], [-1, 1],
                    [0, -1], [0, 1],
                    [1, -1], [1, 0], [1, 1]], T::Array[T::Array[Integer]])

    const :grid, Grid

    sig { params(input: String).returns(Dumbo) }
    def self.build(input)
      Dumbo.new(
        grid: input.strip.split("\n").map { |line| line.strip.chars.map(&:to_i) }
      )
    end

    sig { returns(Integer) }
    def part1_flash_count
      temp = grid.dup
      flash_count = 0

      100.times do
        step_simulation(temp)
        flash_count += count_flashes(temp)
      end

      flash_count
    end

    private

    sig { params(grid: Grid).returns(Grid) }
    def step_simulation(grid)
      grid.each_with_index do |row, i|
        row.each_with_index do |energy, j|
          T.must(grid[i])[j] = energy + 1
        end
      end

      # rubocop:disable Style/CombinableLoops
      grid.each_with_index do |row, i|
        row.each_with_index do |energy, j|
          perform_flashes(i, j, grid) if energy > 9
        end
      end
      # rubocop:enable Style/CombinableLoops
    end

    sig { params(row: Integer, col: Integer, grid: Grid).void }
    def perform_flashes(row, col, grid) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
      return if row.negative? || col.negative? ||
                row >= grid.size || col >= T.must(grid.first).size ||
                T.must(T.must(grid[row])[col]).zero?

      T.must(grid[row])[col] = T.must(T.must(grid[row])[col]) + 1

      return if T.must(T.must(grid[row])[col]) <= 9

      T.must(grid[row])[col] = 0
      DELTAS.each do |(di, dj)|
        perform_flashes(row + T.must(di), col + T.must(dj), grid)
      end
    end

    sig { params(grid: Grid).returns(Integer) }
    def count_flashes(grid)
      count = 0

      grid.each do |row|
        row.each do |energy|
          count += 1 if energy.zero?
        end
      end

      count
    end
  end
end
