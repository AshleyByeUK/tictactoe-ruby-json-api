require 'console_client/text_provider'

module ConsoleClient
  describe TextProvider do
    context "British English" do
      before(:each) do
        @tp = TextProvider
      end

      it "provides an ascii art title" do
        expect(@tp::TITLE).to match "\|\_\_   \_\_\(\_\) \|\_\_   \_\_\|    \|\_\_   \_\_\|         \n"
      end

      it "provides help text" do
        expect(@tp::HELP).to match "Type 'quit' at any time to exit TicTacToe."
      end

      it "povides a main menu text" do
        expect(@tp::MAIN_MENU).to match "1. Play a game.\n2. Quit."
      end

      it "povides a player choice text" do
        expect(@tp::PLAYER_TYPE).to match "Choose a player type"
      end

      it "povides text to return to the main menu" do
        expect(@tp::RETURN_TO_MAIN_MENU).to match "Return to main menu? (Y/N)"
      end

      it "provides text for an invalid selection" do
        expect(@tp::INVALID_SELECTION).to match "option was not recognised"
      end

      it "provides text for a good move" do
        expect(@tp::GOOD_MOVE).to match "Good move"
      end

      it "provides text for a bad position choice" do
        expect(@tp::BAD_MOVE).to match "can't place a token there"
      end

      it "provides text when a game is won" do
        expect(@tp::GAME_OVER).to match "GAME OVER!"
        expect(@tp::WIN).to match "won"
      end

      it "provides text when a game is tied" do
        expect(@tp::GAME_OVER).to match "GAME OVER!"
        expect(@tp::TIE).to match "tie"
      end

      it "thanks the player when quitting" do
        expect(@tp::QUIT).to match "Thanks for playing"
      end
    end
  end
end
