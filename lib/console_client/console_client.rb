require 'game/game'
require 'game/game_engine'
require 'game/player'

module ConsoleClient
  class ConsoleClient
    CONTINUE = true
    EXIT = false

    def initialize(io, text_provider, ui)
      @io = io
      @text_provider = text_provider
      @ui = ui
    end

    def start
      trap("SIGINT") do
        quit_console
      end

      begin
        continue = main_menu
      end while continue
      quit_console
    end

    private

    def main_menu
      main_menu = @text_provider::TITLE + @text_provider::HELP + "\n" + @text_provider::MAIN_MENU + "\n: "
      @io.clear_screen
      @io.display(main_menu)
      case get_validated_input(['1', '2', '3'], @text_provider::INVALID_SELECTION)
      when '1'
        play_game(3)
        return_to_main_menu?
      when '2'
        play_game(4)
        return_to_main_menu?
      else
        EXIT
      end
    end

    def play_game(board_size)
      player_one = configure_player(1, 'X', 'Player 1')
      player_two = configure_player(2, 'O', 'Player 2')
      engine = Game::GameEngine.new(@ui, board_size)
      engine.start(player_one, player_two)
    end

    def configure_player(player, token, name)
      @io.clear_screen
      @io.display(@text_provider::PLAYER_TYPE + "\n: ")
      case get_validated_input(['1', '2', '3'], @text_provider::INVALID_SELECTION)
      when '1'
        Game::Player.create(:human, token, name)
      when '2'
        Game::Player.create(:easy, token, name)
      when '3'
        Game::Player.create(:hard, token, name)
      end
    end

    def return_to_main_menu?
      @io.display(@text_provider::RETURN_TO_MAIN_MENU + "\n: ")
      @io.get_input == 'y' ? CONTINUE : EXIT
    end

    def quit_console
      @io.display(@text_provider::QUIT)
      @io.exit
    end

    def get_validated_input(valid_input, error_message)
      valid = false
      while !valid
        input = @io.get_input
        valid = valid_input.include?(input)
        @io.display(error_message + "\n: ") if !valid
      end
      input
    end
  end
end
