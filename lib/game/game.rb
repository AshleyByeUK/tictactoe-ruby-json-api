require 'game/board'
require 'game/game_rules'

module Game
  class Game
    attr_reader :current_player, :state, :players

    def initialize(players, current_player: 1, board: Board.new, state: :ready)
      @players = players
      @current_player = current_player
      @board = board
      @state = state
      @rules = GameRules.new
    end

    def make_move(ui = nil)
      player = @players[@current_player - 1]
      position = player.make_move(self, ui)
      place_token(position)
    end

    def place_token(position)
      board = @board.place_token(position, @players[@current_player - 1].token)
      if board != @board
        state = @rules.game_result(board) == :playing ? :ok : :game_over
        Game.new(@players, current_player: swap_current_player, board: board, state: state)
      else
        Game.new(@players, current_player: @current_player, board: board, state: :bad_position)
      end
    end

    def current_board
      @board.positions
    end

    def available_positions
      @board.available_positions
    end

    def game_over?
      win? || tie?
    end

    def win?
      @rules.game_result(@board) == :win
    end

    def tie?
      @rules.game_result(@board) == :tie
    end

    def last_player
      swap_current_player
    end

    def current_player_name
      @players[@current_player - 1].name
    end

    def last_player_name
      @players[swap_current_player - 1].name
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
