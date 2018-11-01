require 'console_client/console_io'

module ConsoleClient
  class MockIO < ConsoleIO
    attr_reader :exit_called, :gets_count

    def initialize
      super(device: StringIO.new)
    end

    def init(*inputs)
      @device.puts(inputs.flatten)
      @device.rewind
      @gets_count = 0
      @exit_called = false
    end

    def get_input(valid_input, error_message = '', prompt = '')
      @gets_count += 1
      super(valid_input, error_message, prompt)
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
