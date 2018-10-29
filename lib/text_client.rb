require 'game'
require 'text_client_game'
require 'text_provider'

class TextClient
  def initialize
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
      puts @text_provider.get_text(:play_a_game)
      case gets.chomp
      when 'q', 'quit', 'exit'
        puts @text_provider.get_text(:quit)
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
      puts @text_provider.get_text(:player_type, {player: player})
      options[player] = player_type(gets.to_i)
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
    game = Game.new(options[:player_one], options[:player_two])
    game_client = TextClientGame.new(game, @text_provider)
    game_client.play if game.state == :ready
  end
end
