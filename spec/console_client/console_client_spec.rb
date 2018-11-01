require 'console_client/mock_io'
require 'console_client/console_client'
require 'game/game'

module ConsoleClient
  HUMAN = '1'
  EASY = '2'
  QUIT = 'quit'
  RETURN = "\n"

  describe ConsoleClient do
    before(:each) do
      @io = MockIO.new()
      @client = ConsoleClient.new(@io)
    end

    context "getting user input" do
      ['-1', '10', 'a', 'A', 'pos', '£', ' '].each do |position|
        it "does not allow tokens to be placed in invalid position: #{position}" do
          @io.init(position)
          input = @client.get_input([1, 2, 3, 4, 5, 6, 7, 8, 9], 'quit')
          expect(input.state).to be :invalid_input
          expect(input.value).to be_nil
        end
      end

      ['1', '2', '3', '4', '5', '6', '7', '8', '9', ' 1', '1 ', ' 1 '].each do |position|
        it "allow tokens to be placed in valid position: #{position}" do
          @io.init(position)
          input = @client.get_input([1, 2, 3, 4, 5, 6, 7, 8, 9], 'quit')
          expect(input.state).to be :valid_input
          expect(input.value).to eq position.to_s.strip
        end
      end

      ['quit', 'QUIT', 'quit ', ' quit', ' quit '].each do |command|
        it "accepts '#{command}' as a valid quit command'" do
          @io.init(command)
          input = @client.get_input([], 'quit')
          expect(input.state).to be :valid_input
          expect(input.value).to eq :exit
        end
      end
    end

    context "tests which call 'exit'" do
      around(:each) do |test|
        begin
          test.run
        rescue SystemExit
        end
      end

      context "menu system" do
        it "exits when 'quit' is typed in main menu" do
          @io.init(QUIT)
          # expect(@io.gets_count).to eq 1
          # expect(@client.io.object_id).to eq @io.object_id
          expect(@client.start).to raise_error SystemExit
        end

        it "quits using the quit menu option of the main menu" do
          @io.init('2')
          expect(@client.start).to raise_error SystemExit
        end

        it "quits when choosing not to return to the main menu after a game completes" do
          @io.init('1', EASY, EASY, 'n')
          expect(@client.start).to raise_error SystemExit
        end
      end

      context "human vs human" do
        it "can start and end a game" do
          @io.init('1', HUMAN, HUMAN, '1', '4', '2', '5', '3', QUIT)
          expect(@client.start).to raise_error SystemExit
        end

        it "does not change player when invalid input is entered" do
          @io.init('1', HUMAN, HUMAN, '1', 'BAD', '4', '2', '5', '3', QUIT)
          expect(@client.start).to raise_error SystemExit
        end

        it "does not change player when a duplicate position is given" do
          @io.init('1', HUMAN, HUMAN, '1', '1', '4', '2', '5', '3', QUIT)
          expect(@client.start).to raise_error SystemExit
        end
      end

      context "computer vs computer" do
        it "can play until a tie or win is achieved" do
          @io.init('1', EASY, EASY, QUIT)
          expect(@client.start).to raise_error SystemExit
        end
      end
    end
  end
end
