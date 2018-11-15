require 'console_client/console_io'

module ConsoleClient
  describe ConsoleIO do
    it "displays to the console" do
      output = StringIO.new
      io = ConsoleIO.new(StringIO.new, output)
      io.display('display')
      expect(output.string).to eq "display\n"
    end

    it "gets user input" do
      io = ConsoleIO.new(StringIO.new("input\n"), StringIO.new)
      input = io.get_input
      expect(input).to eq "input"
    end
  end
end
