# typed: strict
# frozen_string_literal: true

require 'set'
require 'sorbet-runtime'

module Day12
  class CaveSystem < T::Struct
    extend T::Sig

    const :graph, T::Hash[String, T::Array[String]]

    sig { params(input: String).returns(CaveSystem) }
    def self.build(input)
      graph = Hash.new([])

      input.strip.split("\n").each do |line|
        cave1, cave2 = line.strip.split('-')
        graph[cave1] += [cave2]
        graph[cave2] += [cave1]
      end

      CaveSystem.new(graph: graph)
    end

    sig { returns(Integer) }
    def part1_path_count
      path_count('start', Set.new)
    end

    private

    sig { params(current: String, visited: T::Set[String]).returns(Integer) }
    def path_count(current, visited)
      return 1 if current == 'end'
      return 0 if visited.include?(current)

      # 'start' will also be marked as visited
      visited.add(current) if current.downcase == current

      # we clone `visited` on every recursion to keep separate histories for each path
      T.must(graph[current]).sum { |cave| path_count(cave, visited.dup) }
    end
  end
end
