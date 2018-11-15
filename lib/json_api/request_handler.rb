require 'game/errors'
require 'json_api/errors'
require 'json_api/game_deserializer'
require 'json_api/game_serializer'
require 'json_api/move_handler'
require 'json_api/player_deserializer'

module JsonAPI
  class RequestHandler
    def initialize(request)
      @request = JSON.parse(request)
      @player_deserializer = PlayerDeserializer.new
      @game_serializer = GameSerializer.new
      @game_deserializer = GameDeserializer.new
    end

    def handle_new_game
      begin
        new_game
      rescue DeserializationError => message
        {"error" => message}
      rescue Exception
        {"error" => "an unknown error occurred"}
      end
    end

    def handle_play_game
      begin
        play_move
      rescue DeserializationError, Game::InvalidPositionError => message
        {"error" => message}
      rescue Exception
        {"error" => "an unknown error occured"}
      end
    end

    private

    def new_game
      players = @player_deserializer.deserialize(@request)
      game = Game::Game.new(players, board_size: board_size_or(3))
      @game_serializer.serialize(game)
    end

    def play_move
      move_handler = MoveHandler.new(@request)
      game = @game_deserializer.deserialize(@request)
      game = game.make_move(move_handler) unless game.game_over?
      @game_serializer.serialize(game)
    end

    def board_size_or(default)
      @request.dig('game', 'board_size') == nil ? default : @request.dig('game', 'board_size')
    end
  end
end
