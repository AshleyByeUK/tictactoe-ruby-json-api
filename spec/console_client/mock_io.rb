module ConsoleClient
  class MockIO
    attr_reader :exit_called, :gets_count

    def initialize()
      @device = StringIO.new
    end

    def init(*inputs)
      @device.puts(inputs.flatten)
      @device.rewind
      @gets_count = 0
      @exit = false
      @exit_called = false
    end

    def get_input(prompt = '')
      @gets_count += 1
      @device.gets.strip.downcase
    end

    def display(text, new_line = "\n")
    end

    def clear_screen
    end

    def exit
      @exit_called = true
    end
  end
end
