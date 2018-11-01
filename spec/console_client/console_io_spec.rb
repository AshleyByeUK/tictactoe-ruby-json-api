require 'console_client/console_io'

module ConsoleClient
  describe ConsoleIO do
    context "displaying text" do
      before(:each) do
        @device = StringIO.new
        @io = ConsoleIO.new(device: @device)
      end

      it "with a default newline" do
        @io.display('display')
        expect(@device.string).to eq "display\n"
      end

      it "with a custom newline" do
        @io.display('display', "\t")
        expect(@device.string).to eq "display\t"
      end
    end

    context "getting user input" do
      ['-1', '10', 'a', 'A', 'pos', '£', ' '].each do |position|
        it "does not allow tokens to be placed in invalid position: #{position}" do
          io = ConsoleIO.new(device: StringIO.new(position))
          input = io.get_input_from_user([1, 2, 3, 4, 5, 6, 7, 8, 9])
          expect(input.state).to be :invalid_input
          expect(input.value).to be_nil
        end
      end

      ['1', '2', '3', '4', '5', '6', '7', '8', '9', ' 1', '1 ', ' 1 '].each do |position|
        it "allow tokens to be placed in valid position: #{position}" do
          io = ConsoleIO.new(device: StringIO.new(position))
          input = io.get_input_from_user([1, 2, 3, 4, 5, 6, 7, 8, 9])
          expect(input.state).to be :valid_input
          expect(input.value).to eq position.to_s.strip
        end
      end

      ['quit', 'QUIT', 'quit ', ' quit', ' quit '].each do |command|
        it "accepts '#{command}' as a valid quit command'" do
          io = ConsoleIO.new(device: StringIO.new(command))
          input = io.get_input_from_user([])
          expect(input.state).to be :valid_input
          expect(input.value).to eq :exit
        end
      end
    end
  end
end
