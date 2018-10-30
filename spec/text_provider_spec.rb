require 'rspec'
require 'text_provider'

describe TextProvider do
  context "British English" do
    before(:each) do
      @provider = TextProvider.new
    end

    it "welcomes the player when in a ready state" do
      text = @provider.get_text(:ready, nil, nil)
      expect(text).to match /Tic Tac Toe!/
    end

    it "informs the player when a good move has been made" do
      text = @provider.get_text(:ok, :playing, :player_one)
      expect(text).to match /Good move/
    end

    it "informs when the wrong player tries to make a move" do
      text = @provider.get_text(:wrong_player, :playing, :player_one)
      expect(text).to match /wrong player/
    end

    it "informs when an invalid player tries to make a move" do
      text = @provider.get_text(:invalid_player, :playing, :bad_player)
      expect(text).to match /invalid player/
    end

    it "informs when an invalid position has been specified" do
      text = @provider.get_text(:invalid_position, :playing, :player_one)
      expect(text).to match /position doesn't exist/
    end

    it "informs when trying to play on an already played position" do
      text = @provider.get_text(:position_taken, :playing, :player_one)
      expect(text).to match /existing marker/
    end

    it "informs when the game is over" do
      text = @provider.get_text(:game_over, :tie, :player_one)
      expect(text).to match /GAME OVER/
    end

    it "informs when the game is a tie" do
      text = @provider.get_text(:game_over, :tie, :player_one)
      expect(text).to match /tie/
    end

    it "informs when the game is won" do
      text = @provider.get_text(:game_over, :win, :player_one)
      expect(text).to match /won/
    end

    it "informs when player one has won the game" do
      text = @provider.get_text(:game_over, :win, :player_one)
      expect(text).to match /Player 1/
    end

    it "informs when player two has won the game" do
      text = @provider.get_text(:game_over, :win, :player_two)
      expect(text).to match /Player 2/
    end

    it "informs when an unknown state occurs" do
      text = @provider.get_text(:unknown, nil, nil)
      expect(text).to match /unexpected event occurred/
    end
  end
end

