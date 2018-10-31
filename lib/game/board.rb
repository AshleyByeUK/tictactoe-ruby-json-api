module Game
  class Board
    EMPTY_BOARD = (1..9).to_a

    attr_reader :error, :positions

    def initialize(positions = EMPTY_BOARD)
      @error = nil
      @positions = positions
    end

    def available_positions
      @positions.select { |pos| pos.is_a?(Integer) }
    end

    def place_token(position, token)
      position_valid?(position) ? apply_token(position, token) : apply_errors(position)
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
      position.is_a?(Integer) || position =~ /\A[-+]?[0-9]+/
    end

    def is_outside_board_range?(position)
      position.to_i < 1 || position.to_i > @positions.length
    end

    def apply_token(position, token)
      positions = Array.new(@positions)
      positions[position.to_i - 1] = token
      Board.new(positions)
    end

    def apply_errors(position)
      @error = validation_reason(position)
      self
    end
  end
end
