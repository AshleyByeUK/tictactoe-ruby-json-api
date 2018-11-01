require 'console_client/text_provider'

module ConsoleClient
  describe TextProvider do
    context "British English" do
      before(:each) do
        @provider = TextProvider.new
      end

      it "provides the correct player for player 1" do
        text = @provider.get_text(1)
        expect(text).to match "Player 1"
      end

      it "provides the correct player for player 2" do
        text = @provider.get_text(2)
        expect(text).to match "Player 2"
      end

      it "provides an ascii art title" do
        text = @provider.get_text(:title)
        expect(text).to match "\|\_\_   \_\_\(\_\) \|\_\_   \_\_\|    \|\_\_   \_\_\|         \n"
      end

      it "provides help text" do
        text = @provider.get_text(:help)
        expect(text).to match "Type 'quit' at any time to exit TicTacToe."
      end

      it "povides a main menu text" do
        text = @provider.get_text(:main_menu)
        expect(text).to match "1. Play a game.\n2. Quit."
      end

      it "povides a player choice text" do
        text = @provider.get_text(:configure_player)
        expect(text).to match "Choose a player type"
      end

      it "povides text to return to the main menu" do
        text = @provider.get_text(:return_to_main_menu)
        expect(text).to match "Return to main menu? (Y/N)"
      end

      it "provides text for an invalid selection" do
        text = @provider.get_text(:invalid_selection)
        expect(text).to match "option was not recognised"
      end

      it "provides an empty string for the games ready state" do
        text = @provider.get_text(:ready)
        expect(text).to match ""
      end

      it "provides text for a good move" do
        text = @provider.get_text(:ok)
        expect(text).to match "Good move"
      end

      it "provides text for a bad position choice" do
        text = @provider.get_text(:bad_position)
        expect(text).to match "can't place a token there"
      end

      it "provides text when a game is won" do
        text = @provider.get_text(:win)
        expect(text).to match "GAME OVER!"
        expect(text).to match "won"
      end

      it "provides text when a game is tied" do
        text = @provider.get_text(:tie)
        expect(text).to match "GAME OVER!"
        expect(text).to match "tie"
      end

      it "thanks the player when quitting" do
        text = @provider.get_text(:quit)
        expect(text).to match "Thanks for playing"
      end

      it "informs when an unknown state occurs" do
        text = @provider.get_text(:unknown)
        expect(text).to match "something unexpected occurred"
      end
    end
  end
end
