require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'json_api/game_deserializer'
require 'json_api/game_serializer'
require 'json_api/player_deserializer'
require 'game/game'

module JsonAPI
  class JsonAPI < Sinatra::Base
    register Sinatra::Namespace

    def initialize
      super
      @player_deserializer = PlayerDeserializer.new
      @game_serializer = GameSerializer.new
      @game_deserializer = GameDeserializer.new
    end

    namespace '/api/v1' do
      new_game = lambda do
        begin
          req_body = request_body
          players = @player_deserializer.deserialize(req_body["players"])
          game = Game::Game.new(players, board_size: board_size_or(req_body, 3))
          json @game_serializer.serialize(game)
        rescue
          json "error" => "invalid players provided"
        end
      end

      play_game = lambda do
        begin
          make_move
        rescue
          json "error" => "invalid game or players"
        end
      end

      post '/game/new', &new_game
      post '/game/play', &play_game
    end

    private

    def make_move
      req_body = request_body
      current_player = req_body.dig('game', 'current_player') == 1 ? 'player_one' : 'player_two'
      current_player_type = req_body.dig('players', current_player, 'type')
      move = req_body.dig('move', 'position')
      game = @game_deserializer.deserialize(req_body)
      if move != nil && current_player_type == 'human'
        game = game.place_token(move) unless game.game_over?
      elsif current_player_type != 'human'
        game = game.make_move unless game.game_over?
      else
        return json "error" => "move position not provided"
      end
      json @game_serializer.serialize(game)
    end

    def request_body
      JSON.parse(request.body.read)
    end

    def board_size_or(req_body, default)
      req_body.dig('game', 'board_size') == nil ? default : req_body.dig('game', 'board_size')
    end
  end
end
