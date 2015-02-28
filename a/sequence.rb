module TaskA
  class Sequence
    attr_reader :elements

    def initialize(line)
      @elements = parse(line).freeze
    end

    def parse(line)
      line.split
    end
  end
end
