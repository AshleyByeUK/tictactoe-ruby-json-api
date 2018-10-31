require 'game/game'
require 'console_client/text_provider'

module ConsoleClient
  class ConsoleClient
    def initialize
      @text_provider = TextProvider.new
    end

    def start
      system "clear"
      puts @text_provider.get_text(:welcome)
      main_ui_loop
      :finished
    end

    def get_input(valid_input = [], error_message = "Error", prompt = '> ')
      quit_commands = ['q', 'quit', 'exit']
      input = gets.strip.downcase
      until input_valid?(input, valid_input, quit_commands)
        puts(error_message)
        print(prompt)
        input = gets.strip.downcase
      end
      quit_commands.include?(input) ? :exit : input
    end

    private

    def main_ui_loop
      loop do
        puts "\n#{@text_provider.get_text(:play_a_game)}"
        case get_input()
        when :exit
          puts "\n#{@text_provider.get_text(:quit)}"
          break
        else
          options = configure_game
          play_game(options)
        end
        system "clear"
      end
    end

    def configure_game
      options = {}
      [:player_one, :player_two].each do |player|
        system "clear"
        puts "#{@text_provider.get_text(:player_type, {player: player})}\n"
        print "> "
        input = get_input([1, 2], 'Invalid option, please try again.')
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
      while game.state != :game_over
        update_ui(game)
        move = game.next_turn == :user ? get_next_move(game) : nil
        break if move == :exit
        game = game.make_move(game.current_player, move)
      end
      update_ui(game)
      get_input([], '', '')
      :finished
    end

    def update_ui(game)
      system "clear"
      print_game_state(game) if game.state == :ready
      print_board(game)
      print_game_state(game) unless game.state == :ready
      print_available_positions(game) unless game.state == :game_over || game.next_turn == :computer
      print_get_next_move_prompt(game) unless game.state == :game_over || game.next_turn == :computer
    end

    def print_game_state(game)
      puts "\n#{@text_provider.get_text(game.state, {result: game.result, player: game.current_player})}"
    end

    def print_board(game)
      board = game.board_state
      puts ""
      draw_row(board[0], board[1], board[2])
      draw_spacer_row
      draw_row(board[3], board[4], board[5])
      draw_spacer_row
      draw_row(board[6], board[7], board[8])
    end

    def draw_row(a, b, c)
      puts " #{marker_for(a)} | #{marker_for(b)} | #{marker_for(c)} "
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
      puts '-----------'
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
      get_input(game.available_positions, "Invalid position, please try again.")
    end

    def input_valid?(input, valid_input, quit_commands)
      quit_commands.include?(input) || valid_input.map(&:to_s).include?(input) || valid_input.empty?
    end
  end
end
