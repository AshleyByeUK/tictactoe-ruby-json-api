require 'game/board'
require 'game/game_rules'

module Game
  class Game
    BAD_POSITION = :bad_position
    GAME_OVER = :game_over
    OK = :ok
    READY = :ready

    attr_reader :current_player, :rules, :state, :players

    def initialize(players, current_player: 1, board_size: 3, board: Board.new(board_size), state: READY)
      @players = players
      @current_player = current_player
      @board = board
      @state = state
      @rules = GameRules.new(@board)
    end

    def make_move(ui = nil)
      player = @players[@current_player - 1]
      position = player.get_move(self, ui)
      place_token(position)
    end

    def place_token(position)
      board = @board.place_token(position, @players[@current_player - 1].token)
      if board != @board
        state = @rules.game_result(board) == :playing ? OK : GAME_OVER
        Game.new(@players, current_player: swap_current_player, board: board, state: state)
      else
        Game.new(@players, current_player: @current_player, board: board, state: BAD_POSITION)
      end
    end

    def current_board
      @board
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

    def current_player_name
      @players[@current_player - 1].name
    end

    def last_player_name
      @players[swap_current_player - 1].name
    end

    def other_players_token
      @players[swap_current_player - 1].token
    end

    private

    def swap_current_player
      @current_player == 1 ? 2 : 1
    end
  end
end
