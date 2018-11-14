ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'json'
require 'json_api/json_api'

describe JsonAPI do
  include Rack::Test::Methods

  def app
    JsonAPI::JsonAPI.new
  end

  context 'creating a new game' do
    it 'returns an error when players are specified' do
      post '/api/v1/game/new', '{}', { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response).to have_key('error')
      expect(response['error']).to eq "invalid players provided"
    end

    it 'returns a game when players are specified' do
      players = '{
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

      post '/api/v1/game/new', players, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response).to have_key('game')
    end

    it 'creates a game with a board size of 4' do
      players = '{
        "game": {
          "board_size": 4
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

      post '/api/v1/game/new', players, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response).to have_key('game')
      expect(response['game']).to have_key('board_size')
      expect(response['game']['board_size']).to eq 4
    end
  end

  context 'playing a game' do
    it 'does not make a human player move when the game is over' do
      serialized_game = '{
        "game": {
          "available_positions": [6, 7, 8, 9],
          "board": ["X", "X", "X", "O", "O", 6, 7, 8, 9],
          "board_size": 3,
          "current_player": 2,
          "state": "playing",
          "result": "win",
          "winner": "Player 1"
        },
        "move": {
          "position": 6
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

      post '/api/v1/game/play', serialized_game, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['game']['board']).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
    end

    it 'does not make a computer player move when the game is over' do
      serialized_game = '{
        "game": {
          "available_positions": [6, 7, 8, 9],
          "board": ["X", "X", "X", "O", "O", 6, 7, 8, 9],
          "board_size": 3,
          "current_player": 2,
          "state": "playing",
          "result": "win",
          "winner": "Player 1"
        },
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "easy"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "easy"
          }
        }
      }'

      post '/api/v1/game/play', serialized_game, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['game']['board']).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
    end

    it 'returns an error when no move is specified for human player' do
      serialized_game = '{
        "game": {
          "available_positions": [6, 7, 8, 9],
          "board": ["X", "X", 3, "O", "O", 6, 7, 8, 9],
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

      post '/api/v1/game/play', serialized_game, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response).to have_key('error')
      expect(response['error']).to eq "move position not provided"
    end

    it 'plays a move when the player is a computer' do
      serialized_game = '{
        "game": {
          "available_positions": [2, 6, 7, 8, 9],
          "board": ["X", 2, "X", "O", "O", 6, 7, 8, 9],
          "board_size": 3,
          "current_player": 1,
          "state": "playing"
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "easy"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "hard"
          }
        }
      }'

      post '/api/v1/game/play', serialized_game, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['game']['board']).not_to eq ["X", 2, "X", "O", "O", 6, 7, 8, 9]
      expect(response['game']['current_player']).to eq 2
    end

    it 'returns an error when incorrect game information is provided' do
      serialized_game = '{
        "game": {
          "available_positions": [6, 7, 8, 9],
          "board_size": 3,
          "current_player": 2,
          "state": "playing",
          "result": "win",
          "winner": "Player 1"
        },
        "move": {
          "position": 6
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

      post '/api/v1/game/play', serialized_game, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response).to have_key('error')
      expect(response['error']).to eq "invalid game or players"
    end

    it 'plays a move when valid position is provided' do
      serialized_game = '{
        "game": {
          "available_positions": [2, 6, 7, 8, 9],
          "board": ["X", 2, "X", "O", "O", 6, 7, 8, 9],
          "board_size": 3,
          "current_player": 1,
          "state": "playing"
        },
        "move": {
          "position": 2
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

      post '/api/v1/game/play', serialized_game, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response['game']['board']).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
      expect(response['game']['result']).to eq "win"
      expect(response['game']['winner']).to eq "Player 1"
    end
  end
end
