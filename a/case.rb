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
      sets = @series.map { |s| Set.new(s.elements) }

      s = sets.first
      sets[1..-1].each do |other|
        s = s.intersection other
      end

      p s
      p s.count

      # search back indexes
    end
  end
end
