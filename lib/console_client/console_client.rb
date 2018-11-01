require 'game/game'
require 'console_client/text_provider'

module ConsoleClient
  Input = Struct.new(:state, :value)

  class ConsoleClient
    attr_reader :io
    def initialize(io = Kernel)
      @io = io
      @text_provider = TextProvider.new
    end

    def start
      loop do
        display_main_menu
      end
    end

    def get_input(valid_input, exit_command = 'quit')
      input = @io.gets.strip.downcase
      if valid_input.map { |v| v.to_s }.include?(input)
        Input.new(:valid_input, input)
      elsif exit_command == input
        Input.new(:valid_input, :exit)
      else
        Input.new(:invalid_input, nil)
      end
    end

    private

    def get_input_from_user(valid_input, error_message = :invalid_selection, prompt = '')
      begin
        display_prompt(prompt)
        input = get_input(valid_input)
        @io.puts(@text_provider.get_text(error_message)) if input.state == :invalid_input
      end until input.state == :valid_input
      if input.value == :exit
        quit
      else
        input.value
      end
    end

    def clear_screen
      @io.system("clear")
    end

    def display_prompt(prompt = '')
      @io.print("#{prompt}> ")
    end

    def quit
      @io.puts(@text_provider.get_text(:quit))
      @io.exit
    end

    def display_main_menu
      clear_screen
      @io.puts(@text_provider.get_text(:title))
      @io.puts(@text_provider.get_text(:help))
      @io.puts(@text_provider.get_text(:main_menu))
      case get_input_from_user(['1', '2']).to_i
      when 1
        player_one = configure_player(1, 'X')
        player_two = configure_player(2, 'O')
        play_game(player_one, player_two)
        display_return_to_main_menu
      when 2
        quit
      end
    end

    def configure_player(player, token)
      clear_screen
      @io.puts(@text_provider.get_text(:configure_player, {player: player}))
      case get_input_from_user(['1', '2']).to_i
      when 1
        Game::Player.create(:human, token)
      when 2
        Game::Player.create(:easy, token)
      end
    end

    def play_game(player_one, player_two)
      game = Game::Game.new([player_one, player_two])
      while ![:win, :tie].include?(game.result)
        clear_screen
        display_board(game.current_board)
        display_game_state(game.state)
        if game.players[game.current_player - 1].name == :human
          prompt = "#{@text_provider.get_text(game.current_player)} "
          input = get_input_from_user(game.available_positions, :bad_position, prompt)
          game = game.make_move(game.current_player, input.to_i)
        else
          game = game.make_move(game.current_player)
        end
      end
      clear_screen
      display_board(game.current_board)
      display_final_result(game.result, game.current_player)
    end

    def display_board(board)
      @io.puts ""
      draw_row(board[0], board[1], board[2])
      draw_spacer_row
      draw_row(board[3], board[4], board[5])
      draw_spacer_row
      draw_row(board[6], board[7], board[8])
    end

    def draw_row(a, b, c)
      @io.puts(" #{a} | #{b} | #{c} ")
    end

    def draw_spacer_row
      @io.puts('-----------')
    end

    def display_game_state(state)
      @io.puts("\n#{@text_provider.get_text(state)}")
    end

    def display_final_result(result, player)
      options = {player: player}
      @io.puts("#{@text_provider.get_text(result, options)}")
    end

    def display_return_to_main_menu
      @io.puts(@text_provider.get_text(:return_to_main_menu))
      input = get_input_from_user(['y', 'n'])
      quit if input == 'n'
    end
  end
end
