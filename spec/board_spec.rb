require 'rspec'
require 'board'

describe Board do
  context "a 3x3 board" do
    before(:each) do
      @board = Board.new()
    end

    it "has 9 available positions" do
      expect(@board.positions()).to eq Array.new(9, Board::AVAILABLE_POSITION)
      expect(@board.available_positions()). to eq [*1..9]
    end

    it "returns a new board after placing a token" do
      updated_board = @board.place_token(1, Board::PLAYER_ONE)
      expect(@board.positions()).to eq Array.new(9, Board::AVAILABLE_POSITION)
      expect(@board.available_positions()).to eq [*1..9]
      expect(updated_board.positions()).to eq [Board::PLAYER_ONE].fill(Board::AVAILABLE_POSITION, 1, 8)
      expect(updated_board.available_positions()).to eq [*2..9]
    end

    it "can place a token for player 1 and player 2" do
      board = @board.place_token(1, Board::PLAYER_ONE)
      board = board.place_token(2, Board::PLAYER_TWO)
      expect(board.positions()).to eq [Board::PLAYER_ONE, Board::PLAYER_TWO].fill(Board::AVAILABLE_POSITION, 2, 7)
      expect(board.available_positions()).to eq [*3..9]
    end

    it "does not allow a token to be placed over an existing token" do
      board = @board.place_token(1, Board::PLAYER_ONE)
      board = board.place_token(1, Board::PLAYER_TWO)
      expect(board.positions()).to eq [Board::PLAYER_ONE].fill(Board::AVAILABLE_POSITION, 1, 8)
      expect(board.available_positions()).to eq [*2..9]
      expect(board.has_errors?()).to be true
      expect(board.errors()).to eq [:position_taken]
    end

    it "does not allow a token to be placed in an invalid position" do
      board = @board.place_token(0, Board::PLAYER_ONE)
      expect(board.positions()).to eq Array.new(9, Board::AVAILABLE_POSITION)
      expect(board.has_errors?()).to be true
      expect(board.errors()).to eq [:invalid_position]
    end

    it "does not have any errors when token placed in valid position" do
      board = @board.place_token(1, Board::PLAYER_ONE)
      expect(board.has_errors?).to be false
      expect(board.errors()).to eq []
    end
  end
end