require 'game/board'

module Game
  describe Board do
    context "a 3x3 board" do
      before(:each) do
        @board = Board.new()
      end

      it "has 9 available positions" do
        expect(@board.positions).to eq [*1..9]
        expect(@board.available_positions). to eq [*1..9]
      end

      it "returns a new board after placing a token" do
        updated_board = @board.place_token(1, Board::PLAYER_ONE)
        expect(updated_board.object_id).not_to eq @board.object_id
      end

      it "can place a token for player 1 and player 2" do
        board = @board.place_token(1, Board::PLAYER_ONE)
                      .place_token(2, Board::PLAYER_TWO)
        expect(board.positions).to eq [Board::PLAYER_ONE, Board::PLAYER_TWO].concat([*3..9])
        expect(board.available_positions).to eq [*3..9]
      end

      it "does not allow a token to be placed over an existing token" do
        board = @board.place_token(1, Board::PLAYER_ONE)
                      .place_token(1, Board::PLAYER_TWO)
        expect(board.positions).to eq [Board::PLAYER_ONE].concat([*2..9])
        expect(board.available_positions).to eq [*2..9]
        expect(board.has_error?).to be true
        expect(board.error).to eq :position_taken
      end

      # TODO: This can be deleted once below two TODO's have been completed.
      it "does not have any errors when token placed in valid position" do
        board = @board.place_token(1, Board::PLAYER_ONE)
        expect(board.has_error?).to be false
        expect(board.error).to be nil
      end

      # TODO: Check that board raises RuntimeError if invalid position given.
      # TODO: Move these two tests to the user interface.
      [-1, 10, "a", "A", "pos", "£", " ", "", nil].each do |position|
        it "does not allow tokens to be placed in invalid position: #{position}" do
          board = @board.place_token(position, Board::PLAYER_ONE)
          expect(board.has_error?).to be true
          expect(board.error).to eq :invalid_position
        end
      end

      it "can place a valid integer passed as a string" do
        board = @board.place_token("1", Board::PLAYER_ONE)
        expect(board.has_error?).to be false
        expect(board.error).to be nil
      end
    end
  end
end
