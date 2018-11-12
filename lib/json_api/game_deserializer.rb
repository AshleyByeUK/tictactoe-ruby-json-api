require 'game/board'
require 'game/game'
require 'game/player'
require 'json_api/player_deserializer'

module JsonAPI
  class GameDeserializer
    def initialize
      @player_deserializer = PlayerDeserializer.new
    end

    def deserialize(serialized_game)
      players = @player_deserializer.deserialize(serialized_game['players'])
      current_player = deserialize_current_player(serialized_game['game'])
      board_size = deserialize_board_size(serialized_game['game'])
      board = deserialize_board(serialized_game['game'])
      state = deserialize_state(serialized_game['game'])
      Game::Game.new(players, current_player:current_player, board_size: board_size, board: board, state: state)
    end

    private

    def deserialize_players(players)
      [
        deserialize_player(players['player_one']),
        deserialize_player(players['player_two'])
      ]
    end

    def deserialize_player(player)
      name = player['name']
      token = player['token']
      type = player['type'].to_sym
      Game::Player.create(type, token, name)
    end

    def deserialize_current_player(game)
      game['current_player']
    end

    def deserialize_board_size(game)
      game['board_size']
    end

    def deserialize_board(game)
      size = deserialize_board_size(game)
      Game::Board.new(size, game['board'])
    end

    def deserialize_state(game)
      game['state'].to_sym
    end
  end
end
