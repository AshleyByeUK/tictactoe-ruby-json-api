require 'game/game'
require 'game/board'
require 'game/easy_player'

module Game
  describe Game do
    before(:each) do
      player_one = Player.create(:human, 'X', 'Player 1')
      player_two = Player.create(:human, 'O', 'Player 2')
      @game = Game.new([player_one, player_two])
    end

    it "has a ready state and current player when initialised" do
      expect(@game.state).to eq :ready
      expect(@game.current_player).to be 1
    end

    it "allows tokens to be placed on a board" do
      game = @game.place_token(1, 1)
      expect(game.object_id).not_to eq @game.object_id
      expect(game.state).to eq :ok
      expect(game.current_board).to eq ['X', *2..9]
      expect(game.available_positions).to eq [*2..9]
    end

    it "does not allow tokens to be placed on top of other tokens" do
      game = @game.place_token(1, 1)
      game = game.place_token(2, 1)
      expect(game.state).to eq :bad_position
      expect(game.current_board).to eq ['X', *2..9]
      expect(game.available_positions).to eq [*2..9]
    end

    [-1, 10, "a", "A", "pos", "£", " ", "", nil].each do |position|
      it "does not allow tokens to be placed in invalid position of '#{position}''" do
        game = @game.place_token(1, position)
        expect(game.state).to eq :bad_position
      end
    end

    it "after one move player two is the current player" do
      game = @game.place_token(1, 1)
      expect(game.current_player).to be 2
    end

    it "after player one and two make a move player one is the current player" do
      game = @game.place_token(1, 1)
      game = game.place_token(2, 2)
      expect(game.current_player).to be 1
    end

    it "correctly places player twos token on the board" do
      game = @game.place_token(1, 1)
      game = game.place_token(2, 2)
      expect(game.current_board).to eq ['X', 'O', *3..9]
      expect(game.available_positions).to eq [*3..9]
    end

    it "does not let an invalid player make a move" do
      expect { @game.place_token(3, 1) }.to raise_error(RuntimeError, 'Invalid player specified')
    end

    it "is still a player's turn after bad move" do
      game = @game.place_token(1, "BAD")
      expect(game.current_player).to be 1
    end

    it "does not let the wrong player make a move" do
      game = @game.place_token(1, 1)
      expect { game.place_token(1, 2) }.to raise_error(RuntimeError, 'Invalid player specified')
    end

    it "returns the status and result of a tied game" do
      game = @game.place_token(1, 1)
                  .place_token(2, 2)
                  .place_token(1, 3)
                  .place_token(2, 5)
                  .place_token(1, 4)
                  .place_token(2, 7)
                  .place_token(1, 9)
                  .place_token(2, 6)
                  .place_token(1, 8)
      expect(game.state).to eq :game_over
      expect(game.tie?).to be true
      expect(game.game_over?).to be true
    end

    it "returns the status and result of a won game" do
      game = @game.place_token(1, 1)
                  .place_token(2, 2)
                  .place_token(1, 3)
                  .place_token(2, 4)
                  .place_token(1, 5)
                  .place_token(2, 6)
                  .place_token(1, 7)
      expect(game.state).to eq :game_over
      expect(game.win?).to be true
      expect(game.game_over?).to be true
    end

    context "player 1 human player vs player 2 computer player" do
      before(:each) do
        player_one = Player.create(:human, 'X', 'Player 1')
        player_two = Player.create(:easy, 'O', 'Player 2')
        @game = Game.new([player_one, player_two])
      end

      it "is first players turn after no moves" do
        expect(@game.current_player).to be 1
      end

      it "is computer players turn after one correct human move" do
        game = @game.place_token(1, 1)
        expect(game.current_player).to be 2
      end

      it "is human players turn after computer's move" do
        game = @game.place_token(1, 1)
        game = game.make_move
        expect(@game.current_player).to be 1
      end
    end
  end
end
