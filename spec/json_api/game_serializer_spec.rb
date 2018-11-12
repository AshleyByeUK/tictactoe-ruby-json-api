require 'game/board'
require 'game/game'
require 'game/player'
require 'json_api/game_serializer'

module JsonAPI
  describe GameSerializer do
    it 'serializes a new game' do
      p1 = Game::Player.create(:human, 'X', 'Player 1')
      p2 = Game::Player.create(:human, 'O', 'Player 2')
      game = Game::Game.new([p1, p2])
      serializer = GameSerializer.new
      serialized_game = serializer.serialize(game)

      expect(serialized_game).to have_key(:game)
      expect(serialized_game[:game]).to have_key(:available_positions)
      expect(serialized_game[:game]).to have_key(:board)
      expect(serialized_game[:game]).to have_key(:board_size)
      expect(serialized_game[:game]).to have_key(:current_player)
      expect(serialized_game[:game]).to have_key(:state)
      expect(serialized_game[:game][:state].is_a?(String)).to be true
      expect(serialized_game).to have_key(:players)
      expect(serialized_game[:players]).to have_key(:player_one)
      expect(serialized_game[:players][:player_one]).to have_key(:name)
      expect(serialized_game[:players][:player_one]).to have_key(:token)
      expect(serialized_game[:players][:player_one]).to have_key(:type)
      expect(serialized_game[:players][:player_one][:type].is_a?(String)).to be true
      expect(serialized_game[:players]).to have_key(:player_two)
      expect(serialized_game[:players][:player_two]).to have_key(:name)
      expect(serialized_game[:players][:player_two]).to have_key(:token)
      expect(serialized_game[:players][:player_two]).to have_key(:type)
      expect(serialized_game[:players][:player_two][:type].is_a?(String)).to be true
      expect(serialized_game[:game]).not_to have_key(:result)
      expect(serialized_game[:game]).not_to have_key(:winner)
    end

    it 'serializes an in progress game' do
      p1 = Game::Player.create(:human, 'X', 'Player 1')
      p2 = Game::Player.create(:human, 'O', 'Player 2')
      board = Game::Board.new(4, ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 12, 13, 14, 15, 16])
      game = Game::Game.new([p1, p2], current_player: 2, board_size: 4, board: board, state: :playing)

      serializer = GameSerializer.new
      serialized_game = serializer.serialize(game)

      expect(serialized_game[:game][:available_positions]).to eq [12, 13, 14, 15, 16]
      expect(serialized_game[:game][:board]).to eq ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 12, 13, 14, 15, 16]
      expect(serialized_game[:game][:board_size]).to eq 4
      expect(serialized_game[:game][:current_player]).to eq 2
      expect(serialized_game[:game][:state]).to eq 'playing'
      expect(serialized_game[:game]).not_to have_key(:result)
      expect(serialized_game[:game]).not_to have_key(:winner)
    end

    it 'serializes a tied game' do
      p1 = Game::Player.create(:human, 'X', 'Player 1')
      p2 = Game::Player.create(:human, 'O', 'Player 2')
      board = Game::Board.new(3, ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'])
      game = Game::Game.new([p1, p2], current_player: 1, board_size: 3, board: board, state: :playing)

      serializer = GameSerializer.new
      serialized_game = serializer.serialize(game)

      expect(serialized_game[:game][:available_positions]).to eq []
      expect(serialized_game[:game][:board]).to eq ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X']
      expect(serialized_game[:game][:result]).to eq 'tie'
      expect(serialized_game[:game]).not_to have_key(:winner)
    end

    it 'serializes a won game' do
      p1 = Game::Player.create(:human, 'X', 'Player 1')
      p2 = Game::Player.create(:human, 'O', 'Player 2')
      board = Game::Board.new(3, ['X', 'X', 3, 'O', 'O', 6, 7, 8, 9])
      game = Game::Game.new([p1, p2], current_player: 1, board_size: 3, board: board, state: :playing)
      game = game.place_token(3)

      serializer = GameSerializer.new
      serialized_game = serializer.serialize(game)

      expect(serialized_game[:game][:available_positions]).to eq [6, 7, 8, 9]
      expect(serialized_game[:game][:board]).to eq ['X', 'X', 'X', 'O', 'O', 6, 7, 8, 9]
      expect(serialized_game[:game][:result]).to eq 'win'
      expect(serialized_game[:game][:winner]).to eq 'Player 1'
    end
  end
end
