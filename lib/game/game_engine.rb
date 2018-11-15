require 'game/errors'

module Game
  class GameEngine
    def initialize(ui, board_size = 3)
      @ui = ui
      @board_size = board_size
    end

    def start(player_one, player_two)
      game = Game.new([player_one, player_two], board_size: @board_size)
      @ui.show_game_state(game)
      game = play_game(game)
      @ui.show_game_result(game)
    end

    private

    def play_game(game)
      while !game.game_over?
        game = play_a_turn(game)
        @ui.show_game_state(game)
      end
      game
    end

    def play_a_turn(game)
      loop do
        made_successful_move, game = make_move(game)
        break if made_successful_move
      end
      game
    end

    def make_move(game)
      begin
        [true, game.make_move(@ui)]
      rescue InvalidPositionError
        @ui.show_invalid_position_message
        [false, game]
      end
    end
  end
end
