require 'console_client/mock_game_ui'
require 'game/game_engine'
require 'game/mock_player'

module Game
  describe GameEngine do
    before(:each) do
      @ui = ConsoleClient::MockGameUI.new
      @engine = GameEngine.new(@ui)
    end

    it "ends a game when the game is won" do
      p1 = MockPlayer.new('X', 1, 2, 3)
      p2 = MockPlayer.new('O', 4, 5)
      @engine.start(p1, p2)
      expect(@ui.show_game_state_called).to eq 6
      expect(@ui.listen_for_user_input_called).to eq 5
      expect(@ui.show_game_result_called). to eq 1
    end

    it "ends a game when the game is tied" do
      p1 = MockPlayer.new('X', 5, 3, 4, 2, 9)
      p2 = MockPlayer.new('O', 1, 7, 6, 8)
      @engine.start(p1, p2)
      expect(@ui.show_game_state_called).to eq 10
      expect(@ui.listen_for_user_input_called).to eq 9
      expect(@ui.show_game_result_called). to eq 1
    end
  end
end
