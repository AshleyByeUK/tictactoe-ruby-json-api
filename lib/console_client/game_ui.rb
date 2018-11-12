module ConsoleClient
  class GameUI
    def initialize(io, text_provider)
      @io = io
      @text_provider = text_provider
    end

    def show_game_state(game)
      output = format_board(game.current_board) + format_message(game)
      @io.clear_screen
      @io.display(output)
    end

    def listen_for_user_input(game)
      prompt = "#{game.current_player_name} "
      @io.get_validated_input(game.available_positions, @text_provider::BAD_MOVE, prompt)
    end

    def show_game_result(game)
      result = ""
      if game.win?
        result = "#{@text_provider::GAME_OVER} #{game.last_player_name} #{@text_provider::WIN}"
      else game.tie?
        result = "#{@text_provider::GAME_OVER} #{@text_provider::TIE}"
      end
      @io.display("\n#{result}\n")
    end

    private

    def format_board(board)
      output = "\n"
      rows = board.get_rows
      rows.each.with_index do |row, i|
        output += format_row(row, board.size)
        output += format_spacer_row(row, board.size) unless i == rows.length - 1
      end
      output
    end

    def format_row(row, width)
      r = ""
      row.each.with_index do |p, i|
        r += " #{p} ".center(width)
        r += "|" unless i == row.length - 1
      end
      r + "\n"
    end

    def format_spacer_row(row, width)
      spacers = (row.length * width) + (row.length - 1)
      spacer_row = ""
      spacers.times { spacer_row += "-" }
      spacer_row + "\n"
    end

    def format_message(game)
      game.state == Game::Game::READY ? "" : "\n#{@text_provider::GOOD_MOVE}\n"
    end
  end
end
