require 'game/game'
require 'console_client/text_provider'

module ConsoleClient
  Input = Struct.new(:state, :value)

  class ConsoleClient
    def initialize(io = Kernel)
      @io = io
      @text_provider = TextProvider.new
    end

    def start
      display_main_menu
      :finished
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

    def clear_screen
      @io.system("clear")
    end

    def display_prompt
      @io.print("> ")
    end

    def quit
      puts "QUITTING!"
      exit
    end

    def display_main_menu
      clear_screen
      @io.puts(@text_provider.get_text(:title))
      @io.puts(@text_provider.get_text(:help))
      @io.puts(@text_provider.get_text(:main_menu))
      begin
        display_prompt
        input = get_input(['1', '2'])
        @io.puts(@text_provider.get_text(:invalid_selection)) if input.state == :invalid_input
      end until input.state == :valid_input
      quit if input.value == :exit
      case input.value.to_i
      when 1
        player_one = configure_player(:player_one, 'X')
        player_two = configure_player(:player_two, 'O')
        play_game(player_one, player_two)
        display_return_to_main_menu
      when 2
        quit
      end
    end

    def configure_player(player, token)
      clear_screen
      @io.puts(@text_provider.get_text(:configure_player, {player: player}))
      begin
        display_prompt
        input = get_input(['1', '2'])
        @io.puts(@text_provider.get_text(:invalid_selection)) if input.state == :invalid_input
      end until input.state == :valid_input
      quit if input.value == :exit
      case input.value.to_i
      when 1
        Game::Player.create(:human, token)
      when 2
        Game::Player.create(:easy, token)
      end
    end

    def display_return_to_main_menu
      @io.puts(@text_provider.get_text(:return_to_main_menu))
    end

    def play_game(player_one, player_two)
      game = Game::Game.new([player_one, player_two])
      while game.state != :game_over
        update_ui(game)
        move = game.players[game.current_player].type == :user ? get_next_move(game) : nil
        break if move == :exit
        game = game.make_move(game.current_player, move)
      end
      update_ui(game)
    end





    def update_ui(game)
      clear_screen
      print_game_state(game) if game.state == :ready
      print_board(game)
      print_game_state(game) unless game.state == :ready
      print_available_positions(game) unless game.state == :game_over || game.players[game.current_player].type == :computer
      print_get_next_move_prompt(game) unless game.state == :game_over || game.players[game.current_player].type == :computer
    end

    def print_game_state(game)
      @io.puts "\n#{@text_provider.get_text(game.state, {result: game.result, player: game.current_player})}"
    end

    def print_board(game)
      board = game.current_board
      @io.puts ""
      draw_row(board[0], board[1], board[2])
      draw_spacer_row
      draw_row(board[3], board[4], board[5])
      draw_spacer_row
      draw_row(board[6], board[7], board[8])
    end

    def draw_row(a, b, c)
      @io.puts " #{marker_for(a)} | #{marker_for(b)} | #{marker_for(c)} "
    end

    def marker_for(id)
      case id
      when 'X'
        "X"
      when 'O'
        "O"
      else
        " "
      end
    end

    def draw_spacer_row
      @io.puts '-----------'
    end

    def print_available_positions(game)
      print "\nAvailable positions: "
      game.available_positions.each { |p| print "#{p} " }
      print "\n"
    end

    def print_get_next_move_prompt(game)
      print "\nMake a move, #{@text_provider.player_text(game.current_player)} > "
    end

    def get_next_move(game)
      get_input(game.available_positions)
    end

    def input_valid?(input, valid_input, quit_commands)
      quit_commands.include?(input) || valid_input.map(&:to_s).include?(input) || valid_input.empty?
    end
  end
end
