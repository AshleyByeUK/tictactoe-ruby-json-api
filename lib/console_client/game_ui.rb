module ConsoleClient
  class GameUI
    def initialize(io, text_provider)
      @io = io
      @text_provider = text_provider
    end

    def show_game_state(game)
      @io.clear_screen
      display_board(game.current_board)
      display_game_state(game)
    end

    def listen_for_user_input(game)
      prompt = "#{game.current_player_name} "
      @io.get_input(game.available_positions, @text_provider::BAD_MOVE, prompt)
    end

    def show_game_result(game)
      options = {player: game.last_player}
      if game.win?
        @io.display("#{@text_provider::GAME_OVER} #{game.last_player_name} #{@text_provider::WIN}")
      else game.tie?
        @io.display("#{@text_provider::TIE}")
      end
    end

    private

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

    def display_game_state(game)
      @io.display("#{@text_provider::GOOD_MOVE}")
    end
  end
end
