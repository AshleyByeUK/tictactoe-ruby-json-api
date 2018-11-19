require 'game/board'
require 'game/game'
require 'game/player'
require 'json_api/errors'
require 'json_api/player_deserializer'

module JsonAPI
  class GameDeserializer
    def initialize
      @player_deserializer = PlayerDeserializer.new
    end

    def deserialize(request_body)
      raise_error_if_invalid(request_body)
      players = @player_deserializer.deserialize(request_body)
      Game::Game.new(players, deserialize_game(request_body['game']))
    end

    private

    def raise_error_if_invalid(request_body)
      raise DeserializationError.new("game is missing") if missing_game?(request_body)
      raise DeserializationError.new("board is missing") if missing_board?(request_body['game'])
      raise DeserializationError.new("current player is missing") if missing_current_player?(request_body['game'])
      raise DeserializationError.new("state is missing") if missing_state?(request_body['game'])
    end

    def missing_game?(request_body)
      !request_body.has_key?('game')
    end

    def missing_board?(game)
      !(game.has_key?('board') && game['board'] != nil)
    end

    def missing_current_player?(game)
      !(game.has_key?('current_player') && game['current_player'] != nil)
    end

    def missing_state?(game)
      !(game.has_key?('state') && game['state'] != nil)
    end

    def deserialize_game(game)
      {
        current_player: deserialize_current_player(game),
        board_size: deserialize_board_size(game),
        board: deserialize_board(game),
        state: deserialize_state(game)
      }
    end

    def deserialize_current_player(game)
      game['current_player']
    end

    def deserialize_board_size(game)
      Math.sqrt(game['board'].length).to_i
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
