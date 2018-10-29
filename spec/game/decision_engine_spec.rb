require 'rspec'
require 'game/board'
require 'game/decision_engine'

module Game
  P1 = Board::PLAYER_ONE
  P2 = Board::PLAYER_TWO

  describe DecisionEngine do
    before(:each) do
      @decision_engine = DecisionEngine.new()
    end

    it "is game over with a tie if no winning combination is played" do
      positions = [P1, P2, P1, P1, P2, P2, P2, P1, P1]
      board = Board.new(positions)
      de = DecisionEngine.new()
      expect(de.game_over?(board)).to be true
      expect(de.result(board)).to eq :tie
    end

    it "is not game over when no win and no tie" do
      board = Board.new()
      expect(@decision_engine.game_over?(board)).to be false
      expect(@decision_engine.result(board)).to eq :playing
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
        expect(@decision_engine.game_over?(board)).to be true
        expect(@decision_engine.result(board)).to be :win
      end
    end

    it "does not declare a win on final move to be a tie" do
      positions = [P1, P2, P1, P2, P1, P1, P2, P2, P1]
      board = Board.new(positions)
      expect(@decision_engine.game_over?(board)).to be true
      expect(@decision_engine.result(board)).to eq :win
    end
  end
end
