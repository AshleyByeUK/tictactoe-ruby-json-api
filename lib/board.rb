class Board
  AVAILABLE_POSITION = -1
  EMPTY_BOARD = Array.new(9, AVAILABLE_POSITION)
  PLAYER_ONE = 1
  PLAYER_TWO = 2

  attr_reader :error, :positions

  def initialize(positions = EMPTY_BOARD)
    @error = nil
    @positions = positions
  end

  def available_positions
    available = []
    @positions.each_with_index { |position, index| available << index if position < 0 }
    available.reject { |pos| pos < 0 }
  end

  def place_token(position, player)
    position_valid?(position) ? apply_token(position, player) : apply_errors(position)
  end

  def has_error?
    @error != nil
  end

  private

  def position_valid?(position)
    is_integer?(position) && available_positions.include?(position)
  end

  def validation_reason(position)
    !is_integer?(position) || is_outside_board_range?(position) ? :invalid_position : :position_taken
  end

  def is_integer?(position)
    Integer(position).is_a? Integer rescue false
  end

  def is_outside_board_range?(position)
    position < 0 || position >= @positions.length
  end

  def apply_token(position, player)
    positions = Array.new(@positions)
    positions[position] = player
    Board.new(positions)
  end

  def apply_errors(position)
    @error = validation_reason(position)
    self
  end
end
