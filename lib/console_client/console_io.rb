module ConsoleClient
  class ConsoleIO
    Input = Struct.new(:state, :value)

    def initialize(input = Kernel, output = Kernel)
      @input = input
      @output = output
    end

    def display(text)
      @output.puts(text)
    end

    def clear_screen
      Kernel.system("clear")
    end

    def exit
      Kernel.exit
    end

    def get_input
      @input.gets.strip.downcase
    end
  end
end
