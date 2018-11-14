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
      @move = nil
    end

    def listen_for_user_input(game)
      request_body.dig('move', 'position')
    end

    namespace '/api/v1' do
      post '/game/new' do
        begin
          players = @player_deserializer.deserialize(request_body["players"])
          game = Game::Game.new(players, board_size: board_size_or(3))
          json @game_serializer.serialize(game)
        rescue
          json "error" => "invalid players provided"
        end
      end

      post '/game/play' do
        begin
          game = @game_deserializer.deserialize(request_body)
          game = game.make_move(self) unless game.game_over?
          json @game_serializer.serialize(game)
        rescue
          json "error" => "invalid game or players"
        end
      end
    end

    private

    def request_body
      request.body.rewind
      JSON.parse(request.body.read)
    end

    def board_size_or(default)
      request_body.dig('game', 'board_size') == nil ? default : request_body.dig('game', 'board_size')
    end
  end
end
