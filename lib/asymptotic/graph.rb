module Asymptotic
  class Graph

    def initialize(problem, algorithm_hash)
      @problem = problem
      @algorithm_hash = algorithm_hash
    end

    def plot
      Gnuplot.open do |gnuplot|
        Gnuplot::Plot.new(gnuplot) do |plot|
          plot.title "Asymptotic Analysis of #{@problem} (#{`ruby -v`.split(' (').first})"
          plot.xlabel "Input size"
          plot.ylabel "Time taken"


          @algorithm_hash.each do |name, function_hash|
            puts "\nRunning benchmarks on: #{name}".green
            seeds = function_hash[:input_seeds]
            input_generation_function = function_hash[:input_function]
            function = function_hash[:function]
            sizes = []
            runtimes = seeds.map do |seed|
              input = input_generation_function.(seed)
              sizes << input.size
              print '.'.yellow
              GC.disable
              time_taken = Benchmark.realtime { function[input] }
              GC.enable
              time_taken
            end

            points = [sizes, runtimes]
            plot.data << Gnuplot::DataSet.new(points) do |set|
              set.with = "linespoints"
              set.title = name
            end

          end
        end
      end

    end

    def self.plot(*args)
      self.new(*args).plot
    end

  end
end

