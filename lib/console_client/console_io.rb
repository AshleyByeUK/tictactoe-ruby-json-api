module ConsoleClient
  class ConsoleIO
    Input = Struct.new(:state, :value)

    def initialize(device = Kernel)
      @device = device
    end

    def display(text, new_line = "\n")
      @device.print(text + new_line)
    end

    def clear_screen
      @device.system("clear")
    end

    def exit
      @device.exit
    end

    def get_validated_input(valid_input, error_message = '', prompt = '')
      input = nil
      loop do
        display_prompt(prompt)
        input = get_input_from_user(valid_input)
        break if input.state == :valid_input
        display(error_message)
      end
      input.value
    end

    def get_input_from_user(valid_input)
      input = @device.gets.strip.downcase
      if valid_input.map { |v| v.to_s }.include?(input)
        Input.new(:valid_input, input)
      else
        Input.new(:invalid_input, nil)
      end
    end

    private

    def display_prompt(prompt = '')
      display("#{prompt}> ", '')
    end
  end
end
