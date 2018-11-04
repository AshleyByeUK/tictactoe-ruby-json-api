require 'game/game'
require 'game/game_engine'

module ConsoleClient
  class ConsoleClient
    def initialize(io, text_provider, ui)
      @io = io
      @text_provider = text_provider
      @ui = ui
    end

    def start
      begin
        continue = display_main_menu
      end while !@io.exit?
      @io.display(@text_provider.get_text(:quit))
      @io.exit
    end

    private

    def display_main_menu
      @io.clear_screen
      @io.display(@text_provider.get_text(:title))
      @io.display(@text_provider.get_text(:help))
      @io.display(@text_provider.get_text(:main_menu))
      case @io.get_input(['1', '2'], @text_provider.get_text(:invalid_selection))
      when '1'
        play_game
      else
        @io.exit = true
      end
    end

    def play_game
      player_one = configure_player(1, 'X')
      player_two = configure_player(2, 'O') unless @io.exit?
      if !@io.exit?
        engine = Game::GameEngine.new(@ui)
        engine.start(player_one, player_two)
      end
      display_return_to_main_menu unless @io.exit?
    end

    def configure_player(player, token)
      @io.clear_screen
      @io.display(@text_provider.get_text(:configure_player, {player: player}))
      case @io.get_input(['1', '2', '3'], @text_provider.get_text(:invalid_selection))
      when '1'
        Game::Player.create(:human, token)
      when '2'
        Game::Player.create(:easy, token)
      when '3'
        Game::Player.create(:hard, token)
      end
    end

    def display_return_to_main_menu
      @io.display(@text_provider.get_text(:return_to_main_menu))
      input = @io.get_input(['y', 'n'], @text_provider.get_text(:invalid_selection))
      @io.exit = true if input != 'y'
    end
  end
end
