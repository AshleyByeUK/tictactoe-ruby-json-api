require 'sinatra/base'
require 'sinatra/cors'
require 'sinatra/json'
require 'sinatra/namespace'
require 'json_api/request_handler'

module JsonAPI
  class JsonAPI < Sinatra::Base
    register Sinatra::Namespace
    register Sinatra::Cors

    set :allow_origin, "*"
    set :allow_methods, "POST"
    set :allow_headers, "content-type"

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
