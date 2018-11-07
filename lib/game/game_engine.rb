module Game
  class GameEngine
    def initialize(ui, board_size = 3)
      @ui = ui
      @board_size = board_size
    end

    def start(player_one, player_two)
      game = Game.new([player_one, player_two], board_size: @board_size)
      @ui.show_game_state(game)
      while !game.game_over?
        game = game.make_move(@ui)
        @ui.show_game_state(game)
      end
      @ui.show_game_result(game)
    end
  end
end
