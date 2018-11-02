module Game
  class Board
    EMPTY_BOARD = (1..9).to_a

    attr_reader :positions

    def initialize(positions = EMPTY_BOARD)
      @positions = positions
    end

    def available_positions
      @positions.select { |pos| pos.is_a?(Integer) }
    end

    def place_token(position, token)
      positions = Array.new(@positions)
      positions[position - 1] = token if available_positions.include?(position)
      Board.new(positions)
    end

    def ==(other)
      @positions == other.positions
    end
  end
end
