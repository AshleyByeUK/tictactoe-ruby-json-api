require 'game/board'
require 'game/game_rules'

module Game
  P1 = Board::PLAYER_ONE
  P2 = Board::PLAYER_TWO

  describe GameRules do
    before(:each) do
      @rules = GameRules.new()
    end

    it "is game over with a tie if no winning combination is played" do
      positions = [P1, P2, P1, P1, P2, P2, P2, P1, P1]
      board = Board.new(positions)
      rules = GameRules.new()
      expect(rules.game_over?(board)).to be true
      expect(rules.game_result(board)).to eq :tie
    end

    it "is not game over when no win and no tie" do
      board = Board.new()
      expect(@rules.game_over?(board)).to be false
      expect(@rules.game_result(board)).to eq :playing
    end

    it "is game over with a win when a winning combination is played" do
      [
        [P1, P1, P1, 3,  4, 5, 6, 7, 8],
        [0, 1, 2, P1, P1, P1, 6, 7, 8],
        [0, 1, 2, 3, 4, 5, P2, P2, P2],
        [P1, P2, 2, P1, P2, 5, P1, 7, 8],
        [0, P1, P2, 3, P1, P2, 6, P1, 8],
        [0, P2, P1, 3, P2, P1, 6, 7, P1],
        [P1, 1, 2, 3, P1, 5, 6, 7, P1],
        [0, 1, P1, 3, P1, 5, P1, 7, 8]
      ].each do |positions|
        board = Board.new(positions)
        expect(@rules.game_over?(board)).to be true
        expect(@rules.game_result(board)).to be :win
      end
    end

    it "does not declare a win on final move to be a tie" do
      positions = [P1, P2, P1, P2, P1, P1, P2, P2, P1]
      board = Board.new(positions)
      expect(@rules.game_over?(board)).to be true
      expect(@rules.game_result(board)).to eq :win
    end
  end
end
