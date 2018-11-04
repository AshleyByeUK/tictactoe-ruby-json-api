require 'console_client/mock_io'
require 'console_client/console_client'
require 'console_client/text_provider_stub'
require 'game/game'
require 'game/mock_game_ui'

module ConsoleClient
  HUMAN = '1'
  EASY = '2'
  HARD = '3'
  QUIT = 'quit'
  RETURN = "\n"

  describe ConsoleClient do
    before(:each) do
      @io = MockIO.new
      text_provider = TextProviderStub.new
      ui = Game::MockGameUI.new
      @client = ConsoleClient.new(@io, text_provider, ui)
    end

    context "menu system" do
      it "exits when 'quit' is typed in main menu" do
        @io.init(QUIT)
        @client.start
        expect(@io.gets_count).to eq 1
        expect(@io.exit_called).to be true
      end

      it "exits when quit option is specified in main menu" do
        @io.init('2')
        @client.start
        expect(@io.gets_count).to eq 1
        expect(@io.exit_called).to be true
      end

      it "quits when 'quit' is typed in player configuration menu" do
        @io.init('1', QUIT)
        @client.start
        expect(@io.gets_count).to eq 2
        expect(@io.exit_called).to be true
      end

      it "quits when choosing not to return to the main menu after a game completes" do
        @io.init('1', EASY, EASY, 'n')
        @client.start
        expect(@io.gets_count).to eq 4
        expect(@io.exit_called).to be true
      end

      # it "quits when typing 'quit' in the game play menu" do
      #   @io.init('1', HUMAN, HUMAN, QUIT)
      #   @client.start
      #   expect(@io.gets_count).to eq 4
      #   expect(@io.exit_called).to be true
      # end

      # Moves mocked out in MockGameUI, so not recorded - so what am I testing?
      context "human vs human" do
        it "can start and end a game" do
          @io.init('1', HUMAN, HUMAN, '1', '4', '2', '5', '3', QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end

        # Moves mocked out in MockGameUI, so not recorded - so what am I testing?
        it "does not change player when invalid input is entered" do
          @io.init('1', HUMAN, HUMAN, '1', 'BAD', '4', '2', '5', '3', QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end

        # Moves mocked out in MockGameUI, so not recorded - so what am I testing?
        it "does not change player when a duplicate position is given" do
          @io.init('1', HUMAN, HUMAN, '1', '1', '4', '2', '5', '3', QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end

        it "can play all the way to a tie" do
          @io.init('1', HUMAN, HUMAN, '5', '9', '7', '3', '6', '4', '8', '2', '1', 'n')
        end
      end

      context "computer vs computer" do
        it "can play at same until a tie or win is achieved" do
          @io.init('1', EASY, EASY, QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end

        # About 2 sec...
        #
        # it "can play at different difficulties until a tie or win is achieved" do
        #   @io.init('1', EASY, HARD, QUIT)
        #   @client.start
        #   expect(@io.gets_count).to eq 4
        #   expect(@io.exit_called).to be true
        # end
      end
    end
  end
end
