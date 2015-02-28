$LOAD_PATH.unshift('.')

require 'case'
require 'sequence'

module TaskA
  class Main
    LEVELS = [:no_of_series, :len_of_series, :series]

    def initialize(filename)
      @filename = filename
      @cases = []
    end

    def parse
      @content ||= load_content(@filename)
      @no_of_cases ||= no_of_cases(@content)

      level = LEVELS.first
      no_of_series = 0
      tcase = nil

      @content[1..-1].each_with_index do |line, n|
        case level
        when :no_of_series
          tcase = Case.new(n)
          @cases << tcase
          no_of_series = line.to_i
          level = :len_of_series
        when :len_of_series then level = :series # don't care, move on
        when :series
          tcase.add_sequence(line)
          no_of_series -=1

          if no_of_series > 0
            level = :len_of_series
          else
            level = :no_of_series
          end
        end
      end
    end

    def process
      @cases.each_with_index do |c, i|
        puts "-" * 100
        puts "case ##{i}"
        puts "-" * 100

        c.solve
      end
    end

    def dump
      @cases.each_with_index do |c, i|
        p "case #{i}"
        c.series.each do |s|
          p s.elements
        end
      end
    end

    def load_content(filename)
      File.readlines(filename).each(&:strip!)
    end

    def no_of_cases(content)
      content.first.to_i
    end
  end
end

task = TaskA::Main.new(ARGV.first)
task.parse
task.process
