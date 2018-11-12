require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'json_api/game_serializer'
require 'json_api/player_deserializer'
require 'game/game'

module JsonAPI
  class JsonAPI < Sinatra::Base
    register Sinatra::Namespace

    namespace '/api/v1' do
      post '/game/new' do
        body = JSON.parse(request.body.read)
        deserializer = PlayerDeserializer.new
        players = deserializer.deserialize(body["players"])
        game = Game::Game.new(players)
        json GameSerializer.new.serialize(game)
      end
    end
  end
end
