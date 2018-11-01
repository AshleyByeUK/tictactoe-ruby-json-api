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
      @io = MockIO.new
      @client = ConsoleClient.new(@io)
    end

    context "tests which call 'exit'" do
      context "menu system" do
        it "exits when 'quit' is typed in main menu" do
          @io.init(QUIT)
          @client.start
          expect(@io.gets_count).to eq 1
          expect(@io.exit_called).to be true
        end

        it "quits using the quit menu option of the main menu" do
          @io.init('2')
          @client.start
          expect(@io.gets_count).to eq 1
          expect(@io.exit_called).to be true
        end

        it "quits when choosing not to return to the main menu after a game completes" do
          @io.init('1', EASY, EASY, 'n')
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end
      end

      context "human vs human" do
        it "can start and end a game" do
          @io.init('1', HUMAN, HUMAN, '1', '4', '2', '5', '3', QUIT)
          @client.start
          expect(@io.gets_count).to eq 9
          expect(@io.exit_called).to be true
        end

        it "does not change player when invalid input is entered" do
          @io.init('1', HUMAN, HUMAN, '1', 'BAD', '4', '2', '5', '3', QUIT)
          @client.start
          expect(@io.gets_count).to eq 9 # Can't explicitly test for '4' with Mock due to get_input's loop.
          expect(@io.exit_called).to be true
        end

        it "does not change player when a duplicate position is given" do
          @io.init('1', HUMAN, HUMAN, '1', '1', '4', '2', '5', '3', QUIT)
          @client.start
          expect(@io.gets_count).to eq 9 # Can't explicitly test for '4' with Mock due to get_input's loop.
          expect(@io.exit_called).to be true
        end
      end

      context "computer vs computer" do
        it "can play until a tie or win is achieved" do
          @io.init('1', EASY, EASY, QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end
      end
    end
  end
end
