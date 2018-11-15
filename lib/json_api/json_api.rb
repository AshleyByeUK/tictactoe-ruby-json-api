require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'json_api/errors'
require 'json_api/game_deserializer'
require 'json_api/game_serializer'
require 'json_api/player_deserializer'
require 'game/errors'
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

    def get_move(game)
      raise DeserializationError.new("missing player's move") if missing_move?(request_body)
      request_body.dig('move', 'position')
    end

    namespace '/api/v1' do
      post '/game/new' do
        begin
          json new_game
        rescue DeserializationError => message
          json "error" => message
        rescue Exception
          json "error" => "an unknown error occurred"
        end
      end

      post '/game/play' do
        begin
          game = @game_deserializer.deserialize(request_body)
          game = game.make_move(self) unless game.game_over?
          json @game_serializer.serialize(game)
        rescue DeserializationError, Game::InvalidPositionError => message
          json "error" => message
        rescue Exception
          json "error" => "an unknown error occured"
        end
      end
    end

    private

    def missing_move?(request_body)
      !request_body.has_key?('move') ||
        !request_body['move'].has_key?('position') ||
        !request_body.dig('move', 'position') == nil
    end

    def new_game
      players = @player_deserializer.deserialize(request_body)
      game = Game::Game.new(players, board_size: board_size_or(3))
      @game_serializer.serialize(game)
    end

    def request_body
      request.body.rewind
      JSON.parse(request.body.read)
    end

    def board_size_or(default)
      request_body.dig('game', 'board_size') == nil ? default : request_body.dig('game', 'board_size')
    end
  end
end
