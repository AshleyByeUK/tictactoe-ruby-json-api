require 'json'
require 'game/game'
require 'game/player'
require 'json_api/game_deserializer'

module JsonAPI
  describe GameDeserializer do
    before(:each) do
      @deserializer = GameDeserializer.new
    end

    it 'deserializes a new game' do
      serialized_game = '{
        "game": {
          "available_positions": [1, 2, 3, 4, 5, 6, 7, 8, 9],
          "board": [1, 2, 3, 4, 5, 6, 7, 8, 9],
          "board_size": 3,
          "current_player": 1,
          "state": "ready"
        },
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'

      game = @deserializer.deserialize(JSON.parse(serialized_game))

      expect(game.available_positions).to eq [*1..9]
      expect(game.current_board.positions).to eq [*1..9]
      expect(game.current_board.size).to eq 3
      expect(game.current_player).to eq 1
      expect(game.state).to eq :ready
      expect(game.players.length).to eq 2
      expect(game.players[0].name).to eq 'Player 1'
      expect(game.players[0].token).to eq 'X'
      expect(game.players[0].type).to eq :human
      expect(game.players[1].name).to eq 'Player 2'
      expect(game.players[1].token).to eq 'O'
      expect(game.players[1].type).to eq :human
      expect(game.game_over?).to be false
    end

    it 'deserializes an in progress game' do
      serialized_game = '{
        "game": {
          "available_positions": [12, 13, 14, 15, 16],
          "board": ["X", "O", "X", "O", "X", "O", "X", "O", "X", "O", "X", 12, 13, 14, 15, 16],
          "board_size": 4,
          "current_player": 2,
          "state": "playing"
        },
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'

      game = @deserializer.deserialize(JSON.parse("#{serialized_game}"))

      expect(game.available_positions).to eq [*12..16]
      expect(game.current_board.positions).to eq ['X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 'O', 'X', 12, 13, 14, 15, 16]
      expect(game.current_board.size).to eq 4
      expect(game.current_player).to eq 2
      expect(game.state).to eq :playing
      expect(game.game_over?).to be false
    end

    it 'deserializes a tied game' do
      serialized_game = '{
        "game": {
          "available_positions": [],
          "board": ["X", "X", "O", "O", "O", "X", "X", "O", "X"],
          "board_size": 3,
          "current_player": 1,
          "state": "playing"
        },
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'

      game = @deserializer.deserialize(JSON.parse("#{serialized_game}"))

      expect(game.available_positions).to eq []
      expect(game.current_board.positions).to eq ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X']
      expect(game.current_board.size).to eq 3
      expect(game.current_player).to eq 1
      expect(game.state).to eq :playing
      expect(game.game_over?).to be true
      expect(game.tie?).to be true
    end

    it 'deserializes a won game' do
      serialized_game = '{
        "game": {
          "available_positions": [],
          "board": ["X", "X", "X", "O", "O", 6, 7, 8, 9],
          "board_size": 3,
          "current_player": 1,
          "state": "playing"
        },
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'

      game = @deserializer.deserialize(JSON.parse("#{serialized_game}"))

      expect(game.available_positions).to eq [6, 7, 8, 9]
      expect(game.current_board.positions).to eq ['X', 'X', 'X', 'O', 'O', 6, 7, 8, 9]
      expect(game.current_board.size).to eq 3
      expect(game.current_player).to eq 1
      expect(game.state).to eq :playing
      expect(game.game_over?).to be true
      expect(game.win?).to be true
    end
  end
end
