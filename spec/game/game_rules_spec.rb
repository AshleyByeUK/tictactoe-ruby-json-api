require 'game/board'
require 'game/game_rules'

module Game
  describe GameRules do
    before(:each) do
      @rules = GameRules.new()
    end

    it "is game over with a tie if no winning combination is played" do
      positions = ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', 'X']
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
        ['X', 'X', 'X', 3,  4, 5, 6, 7, 8],
        [0, 1, 2, 'X', 'X', 'X', 6, 7, 8],
        [0, 1, 2, 3, 4, 5, 'O', 'O', 'O'],
        ['X', 'O', 2, 'X', 'O', 5, 'X', 7, 8],
        [0, 'X', 'O', 3, 'X', 'O', 6, 'X', 8],
        [0, 'O', 'X', 3, 'O', 'X', 6, 7, 'X'],
        ['X', 1, 2, 3, 'X', 5, 6, 7, 'X'],
        [0, 1, 'X', 3, 'X', 5, 'X', 7, 8]
      ].each do |positions|
        board = Board.new(positions)
        expect(@rules.game_over?(board)).to be true
        expect(@rules.game_result(board)).to be :win
      end
    end

    it "does not declare a win on final move to be a tie" do
      positions = ['X', 'O', 'X', 'O', 'X', 'X', 'O', 'O', 'X']
      board = Board.new(positions)
      expect(@rules.game_over?(board)).to be true
      expect(@rules.game_result(board)).to eq :win
    end
  end
end
