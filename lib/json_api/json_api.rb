require 'sinatra/base'
require 'sinatra/json'
require 'sinatra/namespace'
require 'json_api/request_handler'

module JsonAPI
  class JsonAPI < Sinatra::Base
    register Sinatra::Namespace

    def initialize
      super
    end

    namespace '/api/v1' do
      post '/game/new' do
        json RequestHandler.new(request.body.read).handle_new_game
      end

      post '/game/play' do
        json RequestHandler.new(request.body.read).handle_play_game
      end
    end
  end
end
