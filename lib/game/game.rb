require 'game/board'
require 'game/game_rules'
require 'game/player'

module Game
  class Game
    attr_reader :current_player, :last_turn, :result, :state

    def initialize(player_one_strategy = :human, player_two_strategy = :human)
      @board = Board.new()
      @current_player = :player_one
      @rules = GameRules.new()
      @last_turn = {}
      @strategies = build_strategies(player_one_strategy, player_two_strategy)
      @state = :ready
    end

    def make_move(player, position = nil)
      if valid_player?(player) && current_player?(player)
        position = @strategies[@current_player].compute_move(@board, position)
        apply_move(player, position)
      else
        @state = player_error_reason(player)
      end
      self
    end

    def board_state
      @board.positions
    end

    def available_positions
      @board.available_positions
    end

    def next_turn
      @strategies[@current_player].type
    end

    private

    def build_strategies(player_one_strategy, player_two_strategy)
      {player_one: Player.create(player_one_strategy), player_two: Player.create(player_two_strategy)}
    end

  def valid_player?(player)
      player == :player_one || player == :player_two
    end

    def current_player?(player)
      @current_player == player
    end

    def apply_move(player, position)
      token = board_representation_for_player(player)
      @board = @board.place_token(position, token)
      @state = current_game_state
      @result = @rules.game_result(@board)
      @last_turn = {@current_player => position}
      swap_current_player if @state == :ok
    end

    def board_representation_for_player(player)
      player == :player_one ? 'X' : 'O'
    end

    def current_game_state
      @board.has_error? ? @board.error : maybe_game_over(:ok)
    end

    def maybe_game_over(or_state)
      @rules.game_over?(@board) ? :game_over : or_state
    end

    def player_error_reason(player)
      valid_player?(player) ? :wrong_player : :invalid_player
    end

    def swap_current_player
      @current_player = @current_player == :player_one ? :player_two : :player_one
    end
  end
end
