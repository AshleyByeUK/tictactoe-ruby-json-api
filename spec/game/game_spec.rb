require 'game/game'
require 'game/board'
require 'game/easy_player'

module Game
  describe Game do
    before(:each) do
      player_one = Player.create(:human, 'X')
      player_two = Player.create(:human, 'O')
      @game = Game.new([player_one, player_two])
    end

    it "has a ready state and current player when initialised" do
      expect(@game.state).to eq :ready
      expect(@game.current_player).to be 1
    end

    it "allows tokens to be placed on a board" do
      game = @game.make_move(1, 1)
      expect(game.object_id).not_to eq @game.object_id
      expect(game.state).to eq :ok
      expect(game.current_board).to eq ['X', *2..9]
      expect(game.available_positions).to eq [*2..9]
    end

    it "does not allow tokens to be placed on top of other tokens" do
      game = @game.make_move(1, 1)
      game = game.make_move(2, 1)
      expect(game.state).to eq :bad_position
      expect(game.current_board).to eq ['X', *2..9]
      expect(game.available_positions).to eq [*2..9]
    end

    [-1, 10, "a", "A", "pos", "£", " ", "", nil].each do |position|
      it "does not allow tokens to be placed in invalid position of '#{position}''" do
        game = @game.make_move(1, position)
        expect(game.state).to eq :bad_position
      end
    end

    it "after one move player two is the current player" do
      game = @game.make_move(1, 1)
      expect(game.current_player).to be 2
    end

    it "after player one and two make a move player one is the current player" do
      game = @game.make_move(1, 1)
      game = game.make_move(2, 2)
      expect(game.current_player).to be 1
    end

    it "correctly places player twos token on the board" do
      game = @game.make_move(1, 1)
      game = game.make_move(2, 2)
      expect(game.current_board).to eq ['X', 'O', *3..9]
      expect(game.available_positions).to eq [*3..9]
    end

    it "does not let an invalid player make a move" do
      expect { @game.make_move(3, 1) }.to raise_error(RuntimeError, 'Invalid player specified')
    end

    it "is still a player's turn after bad move" do
      game = @game.make_move(1, "BAD")
      expect(game.current_player).to be 1
    end

    it "does not let the wrong player make a move" do
      game = @game.make_move(1, 1)
      expect { game.make_move(1, 2) }.to raise_error(RuntimeError, 'Invalid player specified')
    end

    it "returns the status and result of a tied game" do
      game = @game.make_move(1, 1)
                  .make_move(2, 2)
                  .make_move(1, 3)
                  .make_move(2, 5)
                  .make_move(1, 4)
                  .make_move(2, 7)
                  .make_move(1, 9)
                  .make_move(2, 6)
                  .make_move(1, 8)
      expect(game.state).to eq :ok
      expect(game.result).to eq :tie
      expect(game.game_over?).to be true
    end

    it "returns the status and result of a won game" do
      game = @game.make_move(1, 1)
                  .make_move(2, 2)
                  .make_move(1, 3)
                  .make_move(2, 4)
                  .make_move(1, 5)
                  .make_move(2, 6)
                  .make_move(1, 7)
      expect(game.state).to eq :ok
      expect(game.result).to eq :win
      expect(game.game_over?).to be true
    end

    it "can be ended early" do
      game = @game.make_move(1, 1)
                  .make_move(2, 2)
                  .end_game()
      expect(game.game_over?).to be true
      expect(game.result).to be :playing
    end

    it "is not over midway through a game" do
      game = @game.make_move(1, 1)
      expect(game.game_over?).to be false
      expect(game.result).to be :playing
    end

    context "player 1 human player vs player 2 computer player" do
      before(:each) do
        player_one = Player.create(:human, 'X')
        player_two = Player.create(:easy, 'O')
        @game = Game.new([player_one, player_two])
      end

      it "is first players turn after no moves" do
        expect(@game.current_player).to be 1
      end

      it "is computer players turn after one correct human move" do
        game = @game.make_move(1, 1)
        expect(game.current_player).to be 2
      end

      it "is human players turn after computer's move" do
        game = @game.make_move(1, 1)
        game = game.make_move(2)
        expect(@game.current_player).to be 1
      end

      it "when the current player is a user it passes the user player type" do
        expect(@game.current_player_user?).to be true
      end

      it "when the current player is a computer it passes the computer player type" do
        game = @game.make_move(1, 1)
        expect(game.current_player_user?).to be false
      end
    end
  end
end
