require 'console_client/console_client'
require 'console_client/mock_game_ui'
require 'console_client/mock_io'
require 'console_client/text_provider'
require 'game/game'

module ConsoleClient
  HUMAN = '1'
  EASY = '2'
  HARD = '3'
  QUIT = 'n'

  describe ConsoleClient do
    before(:each) do
      @io = MockIO.new()
      text_provider = TextProvider
      ui = MockGameUI.new
      @client = ConsoleClient.new(@io, text_provider, ui)
    end

    context "menu system" do
      it "exits when quit option is specified in main menu" do
        @io.init('2')
        @client.start
        expect(@io.gets_count).to eq 1
        expect(@io.exit_called).to be true
      end

      it "quits when choosing not to return to the main menu after a game completes" do
        @io.init('1', EASY, EASY, QUIT)
        @client.start
        expect(@io.gets_count).to eq 4
        expect(@io.exit_called).to be true
      end

      it "quits when typing 'ctrl-c'" do
        @io.init('1', HUMAN, HUMAN, Process.kill("SIGINT", 0))
        @client.start
        expect(@io.gets_count).to eq 4
        expect(@io.exit_called).to be true
      end

      context "computer vs computer" do
        it "can play against same type until a tie or win is achieved" do
          @io.init('1', EASY, EASY, QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end

        # About 2 sec...
        #
        it "can play at different difficulties until a tie or win is achieved" do
          @io.init('1', EASY, HARD, QUIT)
          @client.start
          expect(@io.gets_count).to eq 4
          expect(@io.exit_called).to be true
        end
      end
    end
  end
end
