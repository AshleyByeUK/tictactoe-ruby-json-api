module Game
  class GameEngine
    def initialize(ui)
      @ui = ui
    end

    def start(player_one, player_two)
      game = Game.new([player_one, player_two])
      @ui.show_game_state(game)
      while !game.game_over?
        game = game.make_move(@ui)
        @ui.show_game_state(game)
      end
      @ui.show_game_result(game)
    end
  end
end
