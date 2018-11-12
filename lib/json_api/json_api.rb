require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'json_api/game_serializer'
require 'json_api/player_deserializer'
require 'game/game'

module JsonAPI
  class JsonAPI < Sinatra::Base
    register Sinatra::Namespace

    def initialize
      @player_deserializer = PlayerDeserializer.new
      @game_serializer = GameSerializer.new
    end

    namespace '/api/v1' do
      new_game = lambda do
        begin
          players = @player_deserializer.deserialize(request_body["players"])
          game = Game::Game.new(players)
          json @game_serializer.serialize(game)
        rescue
          json "error" => "invalid players provided"
        end
      end

      post '/game/new', &new_game
    end

    def request_body
      JSON.parse(request.body.read)
    end
  end
end
