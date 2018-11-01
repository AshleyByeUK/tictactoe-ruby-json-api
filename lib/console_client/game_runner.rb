module ConsoleClient
  class GameRunner
    def initialize(io, text_provider)
      @io = io
      @text_provider = text_provider
    end

    def play_game(player_one, player_two)
      game = Game::Game.new([player_one, player_two])
      while !game.game_over?
        @io.clear_screen
        display_board(game.current_board)
        display_game_state(game.state)
        game = play_turn(game)
      end
      if game.result == :win || game.result == :tie
        @io.clear_screen
        display_board(game.current_board)
        display_final_result(game.result, game.current_player)
      end
    end

    private

    def play_turn(game)
      prompt = "#{@text_provider.get_text(game.current_player)} "
      input = game.current_player_type == :user ? @io.get_input(game.available_positions, @text_provider.get_text(:bad_position), prompt) : nil
      game.end_game if input == :exit
      game.make_move(game.current_player, input.to_i) unless input == :exit
    end

    def display_board(board)
      @io.display ""
      draw_row(board[0], board[1], board[2])
      draw_spacer_row
      draw_row(board[3], board[4], board[5])
      draw_spacer_row
      draw_row(board[6], board[7], board[8])
    end

    def draw_row(a, b, c)
      @io.display(" #{a} | #{b} | #{c} ")
    end

    def draw_spacer_row
      @io.display('-----------')
    end

    def display_game_state(state)
      @io.display("\n#{@text_provider.get_text(state)}")
    end

    def display_final_result(result, player)
      options = {player: player}
      @io.display("#{@text_provider.get_text(result, options)}")
    end
  end
end
