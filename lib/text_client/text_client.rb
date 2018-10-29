require 'game/game'
require 'text_client/input_provider'
require 'text_client/text_client_game'
require 'text_client/text_provider'

module TextClient
  class TextClient
    def initialize
      @input_provider = InputProvider.new(['q', 'quit', 'exit'])
      @text_provider = TextProvider.new
    end

    def start
      puts @text_provider.get_text(:welcome)
      main_ui_loop
      :finished
    end

    private

    def main_ui_loop
      loop do
        puts "\n#{@text_provider.get_text(:play_a_game)}"
        case @input_provider.get_input()
        when :exit
          puts "\n#{@text_provider.get_text(:quit)}"
          break
        else
          options = configure_game
          play_game(options)
        end
      end
    end

    def configure_game
      options = {}
      [:player_one, :player_two].each do |player|
        puts "#{@text_provider.get_text(:player_type, {player: player})}\n"
        print "> "
        input = @input_provider.get_input([1, 2], 'Invalid option, please try again.')
        options[player] = player_type(input.to_i)
      end
      options
    end

    def player_type(input)
      case input
      when 1
        :human
      when 2
        :easy
      end
    end

    def play_game(options)
      game = Game::Game.new(options[:player_one], options[:player_two])
      game_client = TextClientGame.new(game, @text_provider, @input_provider)
      game_client.play
    end
  end
end
