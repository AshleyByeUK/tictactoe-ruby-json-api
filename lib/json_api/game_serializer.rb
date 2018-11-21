require 'tictactoe/game'

module JsonAPI
  class GameSerializer
    def serialize(game)
      {
        game: serialize_game(game),
        players: serialize_players(game.players)
      }
    end

    private

    def serialize_game(game)
      serialized_game = {
        available_positions: game.available_positions,
        board: game.current_board.positions,
        board_size: game.board_size,
        current_player: game.current_player,
        state: game.state.to_s,
      }
      serialize_game_over(serialized_game, game) if game.game_over?
      serialized_game
    end

    def serialize_game_over(serialized_game, game)
      serialized_game[:result] = game.win? ? "win" : "tie"
      serialized_game[:winner] = game.last_player_name if game.win?
      serialized_game
    end

    def serialize_players(players)
      {
        player_one: serialize_player(players[0]),
        player_two: serialize_player(players[1])
      }
    end

    def serialize_player(player)
      {
        name: player.name,
        token: player.token,
        type: player.type.to_s
      }
    end
  end
end
