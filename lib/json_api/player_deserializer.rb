require 'game/player'

module JsonAPI
  class PlayerDeserializer
    def deserialize(serialized_players)
      players = deserialize_players(serialized_players)
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
  end
end
