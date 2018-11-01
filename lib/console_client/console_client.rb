require 'game/game'
require 'console_client/console_io'
require 'console_client/game_runner'
require 'console_client/text_provider'

module ConsoleClient
  class ConsoleClient
    def initialize(io = ConsoleIO.new)
      @io = io
      @text_provider = TextProvider.new
    end

    def start
      begin
        continue = display_main_menu
      end while continue != :exit
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
        player_one = configure_player(1, 'X')
        player_two = configure_player(2, 'O') unless player_one == :exit
        runner = GameRunner.new(@io, @text_provider)
        player_one == :exit || player_two == :exit || runner.play_game(player_one, player_two) == :exit ? :exit : display_return_to_main_menu
      when 2
        :exit
      else
        :exit
      end
    end

    def configure_player(player, token)
      @io.clear_screen
      @io.display(@text_provider.get_text(:configure_player, {player: player}))
      case @io.get_input(['1', '2'], @text_provider.get_text(:invalid_selection))
      when '1'
        Game::Player.create(:human, token)
      when '2'
        Game::Player.create(:easy, token)
      when :exit
        :exit
      else
        :exit
      end
    end

    def display_return_to_main_menu
      @io.display(@text_provider.get_text(:return_to_main_menu))
      input = @io.get_input(['y', 'n'], @text_provider.get_text(:invalid_selection))
      input == 'n' || input == :exit ? :exit : :continue
    end
  end
end
