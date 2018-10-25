class Board
  AVAILABLE_POSITION = -1
  EMPTY_BOARD = Array.new(9, AVAILABLE_POSITION)
  PLAYER_ONE = 1
  PLAYER_TWO = 2

  attr_reader :errors, :positions

  def initialize(positions = EMPTY_BOARD)
    @errors = []
    @positions = positions
  end

  def available_positions()
    available = []
    @positions.each_with_index() { |pos, idx| available << -pos * (idx + 1) }
    available.reject() { |pos| pos < 0 }
  end

  def place_token(position, player)
    if available_positions.include?(position)
      positions = Array.new(@positions)
      positions[position - 1] = player
      Board.new(positions)
    elsif position < 1 || position > @positions.length()
      @errors << :invalid_position
      self
    else
      @errors << :position_taken
      self
    end
  end

  def has_errors?()
    @errors.length() > 0
  end
end
