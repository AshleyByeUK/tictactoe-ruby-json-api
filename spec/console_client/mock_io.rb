require 'stringio'

module ConsoleClient
  class MockIO
    attr_reader :gets_count

    def init(*inputs)
      @inputs = inputs.flatten
      @io = StringIO.new
      @gets_count = 0
    end

    def gets(*args)
      @io = StringIO.new(@inputs[@gets_count].to_s)
      @gets_count += 1
      @io.gets
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
