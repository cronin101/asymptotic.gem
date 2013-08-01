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
          plot.title "Asymptotic Analysis of #{@problem} (#{`ruby -v`.split(' (').first})"
          plot.xlabel "Input size"
          plot.ylabel "Time taken in seconds"

          @algorithm_hash.each do |name, function_hash|
            puts "\nRunning benchmarks on: #{name}".green
            seeds = function_hash[:input_seeds]
            input_generation_function = function_hash[:input_function]
            function = function_hash[:function]
            inputs = seeds.pmap(8, &input_generation_function)
            sizes = inputs.pmap(8, &:size)
            runtimes = inputs.map do |input|

              GC.disable
              times_taken = ([0] * @attempts).map do
                Benchmark.realtime { function[input] }
              end
              GC.enable

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

