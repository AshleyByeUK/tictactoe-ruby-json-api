require 'board'
require 'decision_engine'

class Game
  attr_reader :current_player, :result, :state

  def initialize()
    @board = Board.new()
    @current_player = :player_one
    @decision_engine = DecisionEngine.new()
    @state = :ready
  end

  def make_move(player, position)
    if valid_player?(player) && current_player?(player)
      token = player == :player_one ? Board::PLAYER_ONE : Board::PLAYER_TWO
      @board = @board.place_token(position, token)
      @state = @board.has_errors? ? @board.errors[0] : :ok
      @state = @decision_engine.game_over?(@board) ? :game_over : @state
      @result = @decision_engine.result(@board)
      swap_current_player if @state == :ok
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

  private

  def valid_player?(player)
    player == :player_one || player == :player_two
  end

  def current_player?(player)
    @current_player == player
  end

  def player_error_reason(player)
    valid_player?(player) ? :wrong_player : :invalid_player
  end

  def swap_current_player
    @current_player = @current_player == :player_one ? :player_two : :player_one
  end
end

