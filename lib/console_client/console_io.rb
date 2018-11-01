module ConsoleClient
  class ConsoleIO
    Input = Struct.new(:state, :value)

    def initialize(exit_command: 'quit', device: Kernel)
      @device = device
      @exit_command = exit_command
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

    def get_input(valid_input, error_message = '', prompt = '')
      begin
        display_prompt(prompt)
        input = get_input_from_user(valid_input)
        display(error_message) if input.state == :invalid_input
      end until input.state == :valid_input
      input.value
    end

    def get_input_from_user(valid_input)
      input = @device.gets.strip.downcase
      if valid_input.map { |v| v.to_s }.include?(input)
        Input.new(:valid_input, input)
      elsif @exit_command == input
        Input.new(:valid_input, :exit)
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
