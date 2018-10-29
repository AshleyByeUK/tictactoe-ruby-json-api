module TextClient
  class InputProvider
    def initialize(quit_commands)
      @quit_commands = quit_commands
    end

    def get_input(valid_input = [], error_message = "Error")
      input = gets.strip.downcase
      until input_valid?(input, valid_input)
        puts(error_message)
        input = gets.strip.downcase
      end
      @quit_commands.include?(input) ? :exit : input
    end

    private

    def input_valid?(input, valid_input)
      @quit_commands.include?(input) || valid_input.map(&:to_s).include?(input) || valid_input.empty?
    end
  end
end
