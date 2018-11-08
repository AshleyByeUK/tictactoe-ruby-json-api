module ConsoleClient
  class GameUI
    def initialize(io, text_provider)
      @io = io
      @text_provider = text_provider
    end

    def show_game_state(game)
      @io.clear_screen
      display_board(game.current_board)
      display_message(game)
    end

    def listen_for_user_input(game)
      prompt = "#{game.current_player_name} "
      @io.get_input(game.available_positions, @text_provider::BAD_MOVE, prompt)
    end

    def show_game_result(game)
      if game.win?
        @io.display("#{@text_provider::GAME_OVER} #{game.last_player_name} #{@text_provider::WIN}")
      else game.tie?
        @io.display("#{@text_provider::GAME_OVER} #{@text_provider::TIE}")
      end
    end

    private

    def display_board(board)
      rows = board.get_rows
      @io.display ""
      rows.each.with_index do |row, i|
        draw_row(row, board.size)
        draw_spacer_row(row, board.size) unless i == rows.length - 1
      end
    end

    def draw_row(row, width)
      r = ""
      row.each.with_index do |p, i|
        r += " #{p} ".center(width)
        r += "|" unless i == row.length - 1
      end
      @io.display(r)
    end

    def draw_spacer_row(row, width)
      spacers = (row.length * width) + (row.length - 1)
      spacer_row = ""
      spacers.times { spacer_row += "-" }
      @io.display(spacer_row)
    end

    def display_message(game)
      @io.display("#{@text_provider::GOOD_MOVE}") unless game.state == Game::Game::READY
    end
  end
end
