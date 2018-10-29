module Game
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
      @positions.map.with_index { |position, index| index if position < 0 }.reject(&:nil?)
    end

    def place_token(position, player)
      position_valid?(position) ? apply_token(position, player) : apply_errors(position)
    end

    def has_error?
      @error != nil
    end

    private

    def position_valid?(position)
      is_integer?(position) && available_positions.include?(position.to_i)
    end

    def validation_reason(position)
      !is_integer?(position) || is_outside_board_range?(position) ? :invalid_position : :position_taken
    end

    def is_integer?(position)
      Integer(position).is_a? Integer rescue false
    end

    def is_outside_board_range?(position)
      position.to_i < 0 || position.to_i >= @positions.length
    end

    def apply_token(position, player)
      positions = Array.new(@positions)
      positions[position.to_i] = player
      Board.new(positions)
    end

    def apply_errors(position)
      @error = validation_reason(position)
      self
    end
  end
end
