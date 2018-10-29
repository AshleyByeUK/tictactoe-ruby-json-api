require 'rspec'
require 'text_provider'

describe TextProvider do
  context "British English" do
    before(:each) do
      @provider = TextProvider.new
    end

    it "welcomes the player when in a ready state" do
      text = @provider.get_text(:ready)
      expect(text).to match /Tic Tac Toe!/
    end

    it "informs the player when a good move has been made" do
      text = @provider.get_text(:ok)
      expect(text).to match /Good move/
    end

    it "informs when the wrong player tries to make a move" do
      text = @provider.get_text(:wrong_player)
      expect(text).to match /wrong player/
    end

    it "informs when an invalid player tries to make a move" do
      text = @provider.get_text(:invalid_player)
      expect(text).to match /invalid player/
    end

    it "informs when an invalid position has been specified" do
      text = @provider.get_text(:invalid_position)
      expect(text).to match /position doesn't exist/
    end

    it "informs when trying to play on an already played position" do
      text = @provider.get_text(:position_taken)
      expect(text).to match /existing marker/
    end

    it "informs when the game is over" do
      text = @provider.get_text(:game_over, {result: :tie, player: :player_one})
      expect(text).to match /GAME OVER/
    end

    it "informs when the game is a tie" do
      text = @provider.get_text(:game_over, {result: :tie, player: :player_one})
      expect(text).to match /tie/
    end

    it "informs when the game is won" do
      text = @provider.get_text(:game_over, {result: :win, player: :player_one})
      expect(text).to match /won/
    end

    it "informs when player one has won the game" do
      text = @provider.get_text(:game_over, {result: :win, player: :player_one})
      expect(text).to match /Player 1/
    end

    it "informs when player two has won the game" do
      text = @provider.get_text(:game_over, {result: :win, player: :player_two})
      expect(text).to match /Player 2/
    end

    it "informs when an unknown state occurs" do
      text = @provider.get_text(:unknown)
      expect(text).to match /unexpected event occurred/
    end

    it "prints an ascii art title" do
      text = @provider.get_text(:welcome)
      expect(text).to match /\|\_\_   \_\_\(\_\) \|\_\_   \_\_\|    \|\_\_   \_\_\|         \n/
    end

    it "requests a player type for player one" do
      text = @provider.get_text(:player_type, {player: :player_one})
      expect(text).to match /type for Player 1/
    end

    it "informs to type 'quit' or press a key to play" do
      text = @provider.get_text(:play_a_game)
      expect(text).to match /key to continue or type 'quit'/
    end
  end
end
