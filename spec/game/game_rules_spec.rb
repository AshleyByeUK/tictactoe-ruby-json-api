require 'game/board'
require 'game/game_rules'

module Game
  describe GameRules do
    before(:each) do
      @rules = GameRules.new(Board.new)
    end

    context "a 3x3 board" do
      it "is game over with a tie if no winning combination is played" do
        positions = ['X', 'O', 'X', 'X', 'O', 'O', 'O', 'X', 'X']
        board = Board.new(3, positions)
        expect(@rules.game_over?(board)).to be true
        expect(@rules.game_result(board)).to eq :tie
      end

      it "is not game over when no win and no tie" do
        board = Board.new
        expect(@rules.game_over?(board)).to be false
        expect(@rules.game_result(board)).to eq :playing
      end

      it "is game over with a win when a winning combination is played" do
        [
          ['X', 'X', 'X', 'O', 'O', 6, 7, 8, 9],
          [1, 2, 3, 'X', 'X', 'X', 'O', 'O', 9],
          [1, 2, 3, 4, 'O', 'O', 'O', 'O', 'O'],
          ['X', 'O', 3, 'X', 'O', 6, 'X', 8, 9],
          [1, 'X', 'O', 4, 'X', 'O', 7, 'X', 9],
          [1, 'O', 'X', 4, 'O', 'X', 7, 8, 'X'],
          ['X', 'O', 'O', 4, 'X', 6, 7, 8, 'X'],
          ['O', 'O', 'X', 4, 'X', 6, 'X', 8, 9]
        ].each do |positions|
          board = Board.new(3, positions)
          expect(@rules.game_over?(board)).to be true
          expect(@rules.game_result(board)).to be :win
        end
      end

      it "does not declare a win on final move to be a tie" do
        positions = ['X', 'O', 'X', 'O', 'X', 'X', 'O', 'O', 'X']
        board = Board.new(3, positions)
        expect(@rules.game_over?(board)).to be true
        expect(@rules.game_result(board)).to eq :win
      end

      it "can be asked if a player has won" do
        board = Board.new(3, ['X', 'X', 'X', 'O', 'O', 6, 7, 8, 9])
        expect(@rules.winner?(board, 'X')).to be true
      end

      it "can be asked if a player has won" do
        board = Board.new(3, ['X', 'X', 'X', 'O', 'O', 6, 7, 8, 9])
        expect(@rules.winner?(board, 'O')).to be false
      end
    end

    context "a 4x4 board" do
      before(:each) do
        @rules = GameRules.new(Board.new(4))
      end

      it "is game over with a tie if no winning combination is played" do
        positions = ['X', 'X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'O', 'X', 'X', 'X', 'O', 'O', 'O']
        board = Board.new(4, positions)
        expect(@rules.game_over?(board)).to be true
        expect(@rules.game_result(board)).to eq :tie
      end

      it "is not game over when no win and no tie" do
        board = Board.new(4)
        expect(@rules.game_over?(board)).to be false
        expect(@rules.game_result(board)).to eq :playing
      end

      it "is game over with a win when a winning combination is played" do
        [
          ['X', 'X', 'X', 'X', 'O', 'O', 'O', 8, 9, 10, 11, 12, 13, 14, 15, 16],
          [1, 2, 3, 4, 'X', 'X', 'X', 'X', 'O', 'O', 'O', 12, 13, 14, 15, 16],
          [1, 2, 3, 4, 5, 6, 7, 8, 'X', 'X', 'X', 'X', 'O', 'O', 'O', 16],
          ['O', 'O', 'O', 4, 5, 6, 7, 8, 9, 10, 11, 12, 'X', 'X', 'X', 'X'],
          ['X', 'O', 'O', 'O', 'X', 6, 7, 8, 'X', 10, 11, 12, 'X', 14, 15, 16],
          [1, 'X', 'O', 'O', 'O', 'X', 7, 8, 9, 'X', 11, 12, 13, 'X', 15, 16],
          [1, 2, 'X', 'O', 'O', 'O', 'X', 8, 9, 10, 'X', 12, 13, 14, 'X', 16],
          [1, 2, 3, 'X', 'O', 'O', 'O', 'X', 9, 10, 11, 'X', 13, 14, 15, 'X'],
          ['X', 'O', 'O', 'O', 5, 'X', 7, 8, 9, 10, 'X', 12, 13, 14, 15, 'X'],
          ['O', 'O', 'O', 'X', 5, 6, 'X', 8, 9, 'X', 11, 12, 'X', 14, 15, 16],
        ].each do |positions|
          board = Board.new(4, positions)
          expect(@rules.game_over?(board)).to be true
          expect(@rules.game_result(board)).to be :win
        end
      end

      it "does not declare a win on final move to be a tie" do
        positions = ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'O', 'X', 'X', 'O', 'O', 'O', 'X', 'X']
        board = Board.new(4, positions)
        expect(@rules.game_over?(board)).to be true
        expect(@rules.game_result(board)).to eq :win
      end
    end
  end
end
