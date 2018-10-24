require 'rspec'
require 'board'

describe Board do
  context "a 3x3 board" do
    it "has 9 available positions" do
      board = Board.new()
      expect(board.available_positions()).to eq Array.new(9, Board::AVAILABLE_POSITION)
    end

    it "can place a token on the board" do
      board = Board.new()
      updated_board = board.place_token(0, Board::PLAYER_ONE)
      expect(board.available_positions()).to eq Array.new(9, Board::AVAILABLE_POSITION)
      expect(updated_board.available_positions()).to eq [Board::PLAYER_ONE].fill(Board::AVAILABLE_POSITION, 1, 8)
    end
  end
end
