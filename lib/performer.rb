require 'ruby-prof'
require 'benchmark'

module Performer


    def memory_usage
        # result = RubyProf.profile do
        #     # code to profile
        # end
        # printer = RubyProf::GraphPrinter.new(result)
        # printer.print(STDOUT, {})
    end

    def speed_test
        # n = 50000
        # Benchmark.bm do |x|
        #     x.report { for i in 1..n; a = "1"; end }
        #     x.report { n.times do   ; a = "1"; end }
        #     x.report { 1.upto(n) do ; a = "1"; end }
        # end
    end

end