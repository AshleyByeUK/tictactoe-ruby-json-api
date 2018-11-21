require 'tictactoe/player'
require 'json_api/errors'

module JsonAPI
  class PlayerDeserializer
    def deserialize(request_body)
      raise_error_if_invalid(request_body)
      deserialize_players(request_body['players'])
    end

    private

    def raise_error_if_invalid(request_body)
      raise DeserializationError.new("a player is missing") if missing_players?(request_body)
      raise DeserializationError.new("player is invalid") if invalid_players?(request_body['players'])
    end

    def missing_players?(request_body)
      !(request_body.has_key?('players') &&
        request_body['players'].has_key?('player_one') &&
        request_body['players'].has_key?('player_two'))
    end

    def invalid_players?(players)
      players.values.reduce(0) { |a, p| a + (invalid_player?(p) ? 1 : 0) } > 0
    end

    def invalid_player?(player)
      !(player.has_key?('name') && player['name'] != nil &&
        player.has_key?('type') && player['type'] != nil &&
        player.has_key?('token') && player['token'] != nil)
    end

    def deserialize_players(players)
      [
        deserialize_player(players['player_one']),
        deserialize_player(players['player_two'])
      ]
    end

    def deserialize_player(player)
      TicTacToe::Player.create(player['type'].to_sym, player['token'], player['name'])
    end
  end
end
