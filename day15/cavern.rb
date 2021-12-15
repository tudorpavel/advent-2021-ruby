# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'rgl/adjacency'
require 'rgl/dijkstra'

module Day15
  class Cavern < T::Struct
    extend T::Sig

    const :risk_matrix, T::Array[T::Array[Integer]]
    const :graph, RGL::DirectedAdjacencyGraph
    const :edge_weights_map, T::Hash[T::Array[String], Integer]

    sig { params(input: String).returns(Cavern) }
    def self.build(input) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
      risk_matrix = input.strip.split("\n").map do |line|
        line.strip.chars.map(&:to_i)
      end

      graph = RGL::DirectedAdjacencyGraph.new
      edge_weights_map = {}

      risk_matrix.each_with_index do |row, y|
        row.each_index do |x|
          u = [x, y].join(',')

          if x < row.size - 1
            v = [x + 1, y].join(',')
            graph.add_edge(u, v)
            edge_weights_map[[u, v]] = T.must(risk_matrix[y])[x + 1]
          end

          if y < risk_matrix.size - 1 # rubocop:disable Style/Next
            v = [x, y + 1].join(',')
            graph.add_edge(u, v)
            edge_weights_map[[u, v]] = T.must(risk_matrix[y + 1])[x]
          end
        end
      end

      Cavern.new(risk_matrix: risk_matrix, graph: graph, edge_weights_map: edge_weights_map)
    end

    sig { returns(Integer) }
    def part1_lowest_total_risk # rubocop:disable Metrics/AbcSize
      dijkstra = RGL::DijkstraAlgorithm.new(graph, edge_weights_map, RGL::DijkstraVisitor.new(graph))
      path = dijkstra.shortest_path('0,0', "#{T.must(risk_matrix[0]).size - 1},#{risk_matrix.size - 1}")

      path.map do |node|
        x, y = node.split(',')
        T.must(risk_matrix[y.to_i])[x.to_i]
      end.sum - T.must(risk_matrix[0])[0]
    end
  end
end
