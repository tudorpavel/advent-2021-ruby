# typed: strict
# frozen_string_literal: true

require 'sorbet-runtime'
require 'rgl/adjacency'
require 'rgl/dijkstra'

module Day15
  class Cavern < T::Struct
    extend T::Sig

    const :risk_matrix, T::Array[T::Array[Integer]]

    sig { params(input: String).returns(Cavern) }
    def self.build(input)
      risk_matrix = input.strip.split("\n").map do |line|
        line.strip.chars.map(&:to_i)
      end

      Cavern.new(risk_matrix: risk_matrix)
    end

    sig { returns(Integer) }
    def part1_lowest_total_risk
      lowest_risk(1)
    end

    sig { returns(Integer) }
    def part2_lowest_total_risk
      lowest_risk(5)
    end

    sig { params(multiplier: Integer).returns(Integer) }
    def lowest_risk(multiplier) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity, Metrics/MethodLength, Metrics/PerceivedComplexity
      graph = RGL::DirectedAdjacencyGraph.new
      edge_weights_map = {}
      n = T.must(risk_matrix[0]).size
      m = risk_matrix.size
      big_n = n * multiplier
      big_m = m * multiplier

      (0..big_m - 1).each do |y|
        (0..big_n - 1).each do |x|
          u = [x, y].join(',')

          if x.positive?
            v = [x - 1, y].join(',')
            graph.add_edge(u, v)
            edge_weights_map[[u, v]] = calculate_risk(x - 1, y, n, m)
          end

          if y.positive?
            v = [x, y - 1].join(',')
            graph.add_edge(u, v)
            edge_weights_map[[u, v]] = calculate_risk(x, y - 1, n, m)
          end

          if x < big_n - 1
            v = [x + 1, y].join(',')
            graph.add_edge(u, v)
            edge_weights_map[[u, v]] = calculate_risk(x + 1, y, n, m)
          end

          if y < big_m - 1 # rubocop:disable Style/Next
            v = [x, y + 1].join(',')
            graph.add_edge(u, v)
            edge_weights_map[[u, v]] = calculate_risk(x, y + 1, n, m)
          end
        end
      end
      dijkstra = RGL::DijkstraAlgorithm.new(graph, edge_weights_map, RGL::DijkstraVisitor.new(graph))
      path = dijkstra.shortest_path('0,0', "#{big_n - 1},#{big_m - 1}")

      path[1..].map do |node|
        x, y = node.split(',').map(&:to_i)
        calculate_risk(x, y, n, m)
      end.sum
    end

    sig { params(x: Integer, y: Integer, n: Integer, m: Integer).returns(Integer) }
    def calculate_risk(x, y, n, m) # rubocop:disable Naming/MethodParameterName
      risk = T.must(T.must(risk_matrix[y % m])[x % n])
      risk += x / n
      risk += y / m
      risk -= 9 while risk > 9
      risk
    end
  end
end
