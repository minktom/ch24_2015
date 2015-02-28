require 'set'

module TaskA
  class Case
    attr_reader :series

    def initialize(n)
      @case_n = n
      @series = []
    end

    def add_sequence(line)
      @series << Sequence.new(line)
    end

    def solve
      seqs = series.map(&:elements).map do |s|
        s.map(&:to_i)
      end
      print 'seqs: '
      p seqs

      commons = seqs.reduce do |x, y|
        x & y
      end
      print 'commons: '
      p commons

      matrix = Hash.new(0)
      commons.combination(2).each do |comb|
        matrix[comb] += 1
      end
      print "matrix 0: "
      p matrix

      seqs.drop(1).each_with_index do |s, i|
        filtered = s & commons
        filtered.combination(2).each do |comb|
          if matrix.has_key? comb
            matrix[comb] += 1
          end
        end
        print "matrix #{i + 1}: "
        p matrix
      end

      ks = matrix.select { |k, v| v == seqs.size }.keys

      graph = {}
      ks.each do |k, v|
        if graph.has_key? k
          graph[k] << v
        else
          graph[k] = [v]
        end
      end
      print 'graph: '
      p graph

      root = commons.find { |common| graph.has_key? common }
      print 'root: '
      p root

      path = [root] + dfs(root, graph)
      print 'path: '
      p path

      print 'path size: '
      p path.size
    end

    def dfs(node, graph)
      # p graph[node]
      graph[node].to_a.each do |child|
        dfs(child, graph)
      end
    end
  end
end
