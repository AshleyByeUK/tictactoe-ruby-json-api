require 'console_client/text_provider'

module ConsoleClient
  describe TextProvider do
    context "British English" do
      before(:each) do
        @text_provider = TextProvider
      end

      it "provides an ascii art title" do
        expect(@text_provider::TITLE).to match "\|\_\_   \_\_\(\_\) \|\_\_   \_\_\|    \|\_\_   \_\_\|         \n"
      end

      it "provides help text" do
        expect(@text_provider::HELP).to match "'quit' or 'ctrl-c'"
      end

      it "povides a main menu text" do
        expect(@text_provider::MAIN_MENU).to include "1. Play a game (3x3)."
        expect(@text_provider::MAIN_MENU).to include "2. Play a game (4x4).\n"
        expect(@text_provider::MAIN_MENU).to include "3. Quit."
      end

      it "povides a player choice text" do
        expect(@text_provider::PLAYER_TYPE).to match "Choose a player type"
      end

      it "povides text to return to the main menu" do
        expect(@text_provider::RETURN_TO_MAIN_MENU).to match "Return to main menu? (Y/N)"
      end

      it "provides text for an invalid selection" do
        expect(@text_provider::INVALID_SELECTION).to match "option was not recognised"
      end

      it "provides text for a good move" do
        expect(@text_provider::GOOD_MOVE).to match "Good move"
      end

      it "provides text for a bad position choice" do
        expect(@text_provider::BAD_MOVE).to match "can't place a token there"
      end

      it "provides text when a game is won" do
        expect(@text_provider::GAME_OVER).to match "GAME OVER!"
        expect(@text_provider::WIN).to match "won"
      end

      it "provides text when a game is tied" do
        expect(@text_provider::GAME_OVER).to match "GAME OVER!"
        expect(@text_provider::TIE).to match "tie"
      end

      it "thanks the player when quitting" do
        expect(@text_provider::QUIT).to match "Thanks for playing"
      end
    end
  end
end
