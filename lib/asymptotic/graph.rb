module Asymptotic
  class Graph

    def initialize(attempts = 5, problem, algorithm_hash)
      @attempts = attempts
      @problem = problem
      @algorithm_hash = algorithm_hash
    end

    def plot
      Gnuplot.open do |gnuplot|
        Gnuplot::Plot.new(gnuplot) do |plot|
          plot.title "Average Runtime Analysis of #{@problem} (#{`ruby -v`.split(' (').first})"
          plot.xlabel "Input size"
          plot.ylabel "Average time taken in seconds (ran #{@attempts} times)"

          @algorithm_hash.each do |name, function_hash|
            seeds = function_hash[:input_seeds]
            input_generation_function = function_hash[:input_function]
            function = function_hash[:function]
            sizes = []

            puts "\nRunning benchmarks on: #{name}".green
            runtimes = seeds.map do |seed|

              size = 0
              times_taken = ([0] * @attempts).map do
                input = input_generation_function.(seed)
                GC.disable
                time_taken  = Benchmark.realtime { function[input] }
                GC.enable
                size = input.size
                time_taken
              end
              sizes << size

              print '.'.yellow
              average_time_taken = times_taken.inject(:+) / @attempts.to_f
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

