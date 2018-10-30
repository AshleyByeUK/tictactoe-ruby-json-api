require 'game/game'
require 'game/board'
require 'game/easy_player'

module Game
  describe Game do
    before(:each) do
      @game = Game.new()
    end

    it "has a ready state and current player when initialised" do
      expect(@game.state).to eq :ready
      expect(@game.current_player).to eq :player_one
    end

    it "allows tokens to be placed on a board" do
      game = @game.make_move(:player_one, 1)
      expect(game.state).to eq :ok
      expect(game.board_state).to eq [Board::PLAYER_ONE].concat([*2..9])
      expect(game.available_positions).to eq [*2..9]
    end

    it "does not allow tokens to be placed on top of other tokens" do
      game = @game.make_move(:player_one, 1)
      game = game.make_move(:player_two, 1)
      expect(game.state).to eq :position_taken
      expect(game.board_state).to eq [Board::PLAYER_ONE].concat([*2..9])
      expect(game.available_positions).to eq [*2..9]
    end

    [-1, 10, "a", "A", "pos", "£", " ", "", nil].each do |position|
      it "does not allow tokens to be placed in #{position}" do
        game = @game.make_move(:player_one, position)
        expect(game.state).to eq :invalid_position
      end
    end

    it "after one move player two is the current player" do
      game = @game.make_move(:player_one, 1)
      expect(game.current_player).to eq :player_two
    end

    it "after player one and two make a move player one is the current player" do
      game = @game.make_move(:player_one, 1)
      game = game.make_move(:player_two, 2)
      expect(game.current_player).to eq :player_one
    end

    it "correctly places player twos token on the board" do
      game = @game.make_move(:player_one, 1)
      game = game.make_move(:player_two, 2)
      expect(game.board_state).to eq [Board::PLAYER_ONE, Board::PLAYER_TWO].concat([*3..9])
      expect(game.available_positions).to eq [*3..9]
    end

    it "does not let an invalid player make a move" do
      game = @game.make_move(:bad_player, 1)
      expect(game.state).to eq :invalid_player
    end

    it "is still a player's turn after bad move" do
      game = @game.make_move(:player_one, "BAD")
      expect(game.current_player).to eq :player_one
    end

    it "does not let the wrong player make a move" do
      game = @game.make_move(:player_one, 1)
      game = game.make_move(:player_one, 2)
      expect(game.state).to eq :wrong_player
    end

    it "returns the status and result of the game" do
      [
        [:player_one, 1],
        [:player_two, 2],
        [:player_one, 3],
        [:player_two, 5],
        [:player_one, 4],
        [:player_two, 7],
        [:player_one, 9],
        [:player_two, 6],
        [:player_one, 8]
      ].each { |move| @game = @game.make_move(move[0], move[1]) }
      expect(@game.state).to eq :game_over
      expect(@game.result).to eq :tie
    end

    context "player 1 human player vs player 2 computer player" do
      before(:each) do
        @game = Game.new(:human, :easy)
      end
      it "is human players turn after no moves" do
        expect(@game.last_turn).to be {}
        expect(@game.next_turn).to eq :user
      end

      it "is computer players turn after one correct human move" do
        game = @game.make_move(:player_one, 1)
        expect(game.last_turn).to include(player_one: 1)
        expect(game.next_turn).to eq :computer
      end

      it "is human players turn after computer's move" do
        game = @game.make_move(:player_one, 1)
        allow_any_instance_of(EasyPlayer).to receive(:compute_move).and_return(2)
        game = game.make_move(:player_two)
        expect(game.last_turn).to include(player_two: 2)
        expect(game.next_turn).to eq :user
      end
    end
  end
end
