require 'game/board'

module Game
  describe Board do
    context "a 3x3 board" do
      before(:each) do
        @board = Board.new
      end

      it "has 9 available positions" do
        expect(@board.positions).to eq [*1..9]
        expect(@board.available_positions).to eq [*1..9]
      end

      it "returns a new board after placing a token" do
        updated_board = @board.place_token(1, 'X')
        expect(updated_board.object_id).not_to eq @board.object_id
        expect(updated_board).not_to eq @board
      end

      it "can place a token for player 1 and player 2" do
        board = @board.place_token(1, 'X')
                      .place_token(2, 'O')
        expect(board.positions).to eq ['X', 'O', *3..9]
        expect(board.available_positions).to eq [*3..9]
      end

      it "does not allow a token to be placed over an existing token" do
        board = @board.place_token(1, 'X')
                      .place_token(1, 'O')
        expect(board.positions).to eq ['X', *2..9]
        expect(board.available_positions).to eq [*2..9]
      end

      it "is equal to another board when all positions are the same" do
        expect(@board).to eq Board.new
      end

      it "provides positions by row" do
        expect(@board.get_rows.length).to eq 3
      end
    end

    context "a 4x4 board" do
      before(:each) do
        @board = Board.new(4)
      end

      it "has 16 available positions" do
        expect(@board.positions).to eq [*1..16]
        expect(@board.available_positions).to eq [*1..16]
      end
    end
  end
end
