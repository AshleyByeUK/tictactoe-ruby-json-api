ENV['RACK_ENV'] = 'test'

require 'json_api/json_api'
require 'rspec'
require 'rack/test'
require 'json'

describe JsonAPI do
  include Rack::Test::Methods

  before(:each) do
    @players = '{
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

    @serialized_game = '{
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

  end

  def app
    JsonAPI::JsonAPI.new
  end

  context 'creating a new game' do
    it 'returns a game when players are specified' do
      post '/api/v1/game/new', @players, { 'CONTENT_TYPE' => 'application/json' }

      expect(last_response).to be_ok

      response = JSON.parse(last_response.body)
      expect(response).to have_key('game')
    end
  end
end
