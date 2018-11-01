require 'game/board'
require 'game/game_rules'
require 'game/player'

module Game
  class Game
    attr_reader :current_player, :state, :players

    def initialize(players, current_player = 1, board = Board.new(), state = :ready)
      @players = players
      @current_player = current_player
      @board = board
      @state = state
      @rules = GameRules.new()
    end

    def make_move(player, position = nil)
      raise RuntimeError, 'Invalid player specified' if invalid_player?(player)

      position = @players[player - 1].compute_move(@board, position)
      updated_board = @board.place_token(position, @players[player - 1].token)
      if updated_board != @board
        Game.new(@players, swap_current_player, updated_board, :ok)
      else
        Game.new(@players, @current_player, updated_board, :bad_position)
      end
    end

    def current_board
      @board.positions
    end

    def current_player_type
      @players[@current_player - 1].type
    end

    def available_positions
      @board.available_positions
    end

    def result
      @rules.game_result(@board)
    end

    def end_game
      Game.new(@players, @current_player, @board, :game_over)
    end

    def game_over?
      @state == :game_over || result != :playing ? true : false
    end

    private

    def invalid_player?(player)
      @current_player != player || player < 1 || player > @players.length
    end

    def swap_current_player
      @current_player == 1 ? 2 : 1
    end
  end
end
