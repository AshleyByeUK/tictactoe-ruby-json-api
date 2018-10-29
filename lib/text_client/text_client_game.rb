module TextClient
  class TextClientGame
    def initialize(game, text_provider, input_provider)
      @game = game
      @input_provider = input_provider
      @text_provider = text_provider
    end

    def play
      while @game.state != :game_over
        update_ui
        move = @game.next_turn == :user ? get_next_move : nil
        break if move == :exit
        @game = @game.make_move(@game.current_player, move)
      end
      update_ui
      :finished
    end

    private

    def update_ui
      print_game_state if @game.state == :ready
      print_board
      print_game_state unless @game.state == :ready
      print_available_positions unless @game.state == :game_over || @game.next_turn == :computer
      print_get_next_move_prompt unless @game.state == :game_over || @game.next_turn == :computer
    end

    def print_board
      board = @game.board_state
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
      when 1
        "X"
      when 2
        "O"
      else
        " "
      end
    end

    def draw_spacer_row
      puts '-----------'
    end

    def print_game_state
      puts "\n#{@text_provider.get_text(@game.state, {result: @game.result, player: @game.current_player})}"
    end

    def print_available_positions
      print "\nAvailable positions: "
      @game.available_positions.each { |p| print "#{p} " }
      print "\n"
    end

    def print_get_next_move_prompt
      print "\nMake a move, #{@text_provider.player_text(@game.current_player)} > "
    end

    def get_next_move
      @input_provider.get_input(@game.available_positions, "Invalid position, please try again.")
      # input == :exit ? (puts(@text_provider.get_text(:quit)); exit) : input
    end
  end
end
