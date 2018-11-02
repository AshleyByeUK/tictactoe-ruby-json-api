module ConsoleClient
  class GameRunner
    def initialize(io, text_provider)
      @io = io
      @text_provider = text_provider
    end

    def play_game(player_one, player_two)
      game = Game::Game.new([player_one, player_two])
      @io.clear_screen
      display_board(game.current_board)
      while !game.game_over?
        game = play_turn(game)
        update_display(game)
      end
    end

    private

    def play_turn(game)
      if @io.exit?
        game.end_game
      else
        game.make_move
      end
    end

    def update_display(game)
      if !game.game_ended? && !@io.exit?
        @io.clear_screen
        display_board(game.current_board)
        display_game_state(game)
      end
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

    def display_game_state(game)
      options = {player: game.last_player}
      if game.win?
        @io.display("#{@text_provider.get_text(:win, options)}")
      elsif game.tie?
        @io.display("#{@text_provider.get_text(:tie)}")
      else
        @io.display("#{@text_provider.get_text(:ok)}")
      end
    end
  end
end
