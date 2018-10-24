class Board
  AVAILABLE_POSITION = -1
  EMPTY_BOARD = Array.new(9, AVAILABLE_POSITION)
  PLAYER_ONE = 1

  def initialize()
    @available_positions = EMPTY_BOARD
  end

  def available_positions()
    @available_positions
  end

  protected def available_positions=(available_positions)
    @available_positions = available_positions
  end

  def place_token(position, player)
    positions = Array.new(@available_positions)
    positions[position] = player
    updated_board = Board.new()
    updated_board.available_positions = positions
    updated_board
  end
end
