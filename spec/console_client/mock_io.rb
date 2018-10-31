require 'stringio'

module ConsoleClient
  class MockIO
    attr_reader :gets_count

    def initialize(*inputs)
      @inputs = inputs.flatten
      @io = StringIO.new
    end

    def init(*inputs)
      @inputs = inputs.flatten
      @gets_count = 0
    end

    def gets(*args)
      @io.puts(@inputs[@gets_count].to_s)
      @gets_count += 1
      @io.rewind
      @io.string
    end

    def puts(*args)
      @io.puts
    end

    def print(*args)
      @io.puts
    end

    def system(*args)
    end
  end
end
