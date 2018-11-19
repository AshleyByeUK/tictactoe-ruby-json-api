ENV['RACK_ENV'] = 'test'

require 'rack/test'
require 'json'
require 'json_api/json_api'
require 'json_api/json_requests'

module JsonAPI
  describe JsonAPI do
    include JsonRequests
    include Rack::Test::Methods

    def app
      JsonAPI.new
    end

    context 'creating a new game' do
      it 'returns an error when no players are specified' do
        post '/api/v1/game/new', JsonRequests.empty_json_object

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "a player is missing"
      end

      it 'returns an error when one player is specified' do
        post '/api/v1/game/new', JsonRequests.invalid_new_game_only_one_player

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "a player is missing"
      end

      it 'returns an error when a player is specified with missing information' do
        post '/api/v1/game/new', JsonRequests.invalid_new_game_missing_player_info

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "player is invalid"
      end

      it 'returns a game when players are specified' do
        post '/api/v1/game/new', JsonRequests.valid_new_game

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('game')
      end

      it 'creates a game with a board size of 4' do
        post '/api/v1/game/new', JsonRequests.valid_new_game_board_size_4

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('game')
        expect(response['game']).to have_key('board_size')
        expect(response['game']['board_size']).to eq 4
      end
    end

    context 'playing a game' do
      it 'returns an error when nothing is specified' do
        post '/api/v1/game/play', JsonRequests.empty_json_object

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "game is missing"
      end

      it 'does not make a human player move when the game is over' do
        post '/api/v1/game/play', JsonRequests.valid_human_game_is_over

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response['game']['board']).to eq ["X", "X", "X", "X", "O", "O", "O", 8, 9, 10, 11, 12, 13, 14, 15, 16]
        expect(response['game']['result']).to eq 'win'
        expect(response['game']['winner']).to eq 'Player 1'
      end

      it 'does not make a computer player move when the game is over' do
        post '/api/v1/game/play', JsonRequests.valid_computer_game_is_over

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response['game']['board']).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
      end

      it 'returns an error when no players are specified' do
        post '/api/v1/game/play', JsonRequests.invalid_game_no_players

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "a player is missing"
      end

      it 'returns an error when no move is specified for human player' do
        post '/api/v1/game/play', JsonRequests.invalid_game_no_human_move_given

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "missing player's move"
      end

      it 'returns an error when an invalid move is specified for human player' do
        post '/api/v1/game/play', JsonRequests.invalid_game_invalid_move_given

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "invalid position"
      end

      it 'plays a move when the player is a computer' do
        post '/api/v1/game/play', JsonRequests.valid_game_computers_move

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response['game']['board']).not_to eq ["X", 2, "X", "O", "O", 6, 7, 8, 9]
        expect(response['game']['current_player']).to eq 2
      end

      it 'returns an error when no game information is provided' do
        post '/api/v1/game/play', JsonRequests.invalid_game_missing_game_info

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "game is missing"
      end

      it 'returns an error when no board is provided' do
        post '/api/v1/game/play', JsonRequests.invalid_game_missing_board

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "board is missing"
      end

      it 'returns an error when no current player is provided' do
        post '/api/v1/game/play', JsonRequests.invalid_game_missing_current_player

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "current player is missing"
      end

      it 'returns an error when no state is provided' do
        post '/api/v1/game/play', JsonRequests.invalid_game_missing_state

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response).to have_key('error')
        expect(response['error']).to eq "state is missing"
      end

      it 'plays a move when valid position is provided' do
        post '/api/v1/game/play', JsonRequests.valid_game_human_move

        expect(last_response).to be_ok

        response = JSON.parse(last_response.body)
        expect(response['game']['board']).to eq ["X", "X", "X", "O", "O", 6, 7, 8, 9]
        expect(response['game']['result']).to eq "win"
        expect(response['game']['winner']).to eq "Player 1"
      end
    end
  end
end
