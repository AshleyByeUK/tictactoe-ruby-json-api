require 'game/game'
require 'game/mock_player'
require 'console_client/mock_game_ui'

module Game
  describe Game do
    it "has a ready state and current player when initialised" do
      mock_player = MockPlayer.new('X')
      game = Game.new([mock_player, mock_player])
      expect(game.state).to eq :ready
      expect(game.current_player).to be 1
    end

    it "provides the name of the current and last player" do
      mock_player = MockPlayer.new('X')
      game = Game.new([mock_player, mock_player])
      expect(game.current_player_name).to eq 'Mock Player'
      expect(game.last_player_name).to eq 'Mock Player'
    end

    it "allows tokens to be placed on a board" do
      player_one = MockPlayer.new('X', [1])
      player_two = MockPlayer.new('O')
      game = Game.new([player_one, player_two])
      updated_game = game.make_move(ConsoleClient::MockGameUI.new)
      expect(updated_game.object_id).not_to eq game.object_id
      expect(updated_game.state).to eq :ok
      expect(updated_game.current_board).to eq ['X', *2..9]
      expect(updated_game.available_positions).to eq [*2..9]
    end

    it "does not allow tokens to be placed on top of other tokens" do
      game_ui = ConsoleClient::MockGameUI.new
      player_one = MockPlayer.new('X', [1])
      player_two = MockPlayer.new('O', [1])
      game = Game.new([player_one, player_two])
          .make_move(game_ui)
          .make_move(game_ui)
      expect(game.state).to eq :bad_position
      expect(game.current_board).to eq ['X', *2..9]
      expect(game.available_positions).to eq [*2..9]
    end

    [-1, 10, "a", "A", "pos", "£", " ", "", nil].each do |position|
      it "does not allow tokens to be placed in invalid position of '#{position}''" do
        player_one = MockPlayer.new('X', [position])
        player_two = MockPlayer.new('O')
        game = Game.new([player_one, player_two])
            .make_move(ConsoleClient::MockGameUI.new)
        expect(game.state).to eq :bad_position
      end
    end

    it "after one move player two is the current player" do
      player_one = MockPlayer.new('X', [1])
      player_two = MockPlayer.new('O')
      game = Game.new([player_one, player_two])
          .make_move(ConsoleClient::MockGameUI.new)
      expect(game.current_player).to be 2
    end

    it "after player one and two make a move player one is the current player" do
      game_ui = ConsoleClient::MockGameUI.new
      player_one = MockPlayer.new('X', [1])
      player_two = MockPlayer.new('O', [2])
      game = Game.new([player_one, player_two])
          .make_move(game_ui)
          .make_move(game_ui)
      expect(game.current_player).to be 1
    end

    it "correctly places player twos token on the board" do
      game_ui = ConsoleClient::MockGameUI.new
      player_one = MockPlayer.new('X', [1])
      player_two = MockPlayer.new('O', [2])
      game = Game.new([player_one, player_two])
          .make_move(game_ui)
          .make_move(game_ui)
      expect(game.current_board).to eq ['X', 'O', *3..9]
      expect(game.available_positions).to eq [*3..9]
    end

    it "is still a player's turn after bad move" do
      game_ui = ConsoleClient::MockGameUI.new
      player_one = MockPlayer.new('X', ["BAD"])
      player_two = MockPlayer.new('O')
      game = Game.new([player_one, player_two])
          .make_move(game_ui)
      expect(game.current_player).to be 1
    end

    it "returns the status and result of a tied game" do
      game_ui = ConsoleClient::MockGameUI.new
      player_one = MockPlayer.new('X', [1, 3, 4, 9, 8])
      player_two = MockPlayer.new('O', [2, 5, 7, 6])
      game = Game.new([player_one, player_two])
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
      expect(game.state).to eq :game_over
      expect(game.tie?).to be true
      expect(game.game_over?).to be true
    end

    it "returns the status and result of a won game" do
      game_ui = ConsoleClient::MockGameUI.new
      player_one = MockPlayer.new('X', [1, 2, 3])
      player_two = MockPlayer.new('O', [4, 5])
      game = Game.new([player_one, player_two])
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
          .make_move(game_ui)
      expect(game.state).to eq :game_over
      expect(game.win?).to be true
      expect(game.game_over?).to be true
    end
  end
end
