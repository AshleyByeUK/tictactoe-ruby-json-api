module Game
  class Board
    attr_reader :positions, :size

    def initialize(size = 3, positions = (1..size*size).to_a)
      @size = size
      @positions = positions
    end

    def available_positions
      @positions.select { |pos| pos.is_a?(Integer) }
    end

    def place_token(position, token)
      positions = Array.new(@positions)
      positions[position - 1] = token if available_positions.include?(position)
      Board.new(@size, positions)
    end

    def possible_winning_positions
      get_rows
          .concat(get_columns)
          .concat(get_diagonals)
    end

    def get_rows
      @positions.each_slice(@size).to_a
    end

    def ==(other)
      @positions == other.positions
    end

    private

    def get_columns
      get_rows.transpose
    end

    def get_diagonals
      [get_top_left_bottom_right_diagonal, get_top_right_bottom_left_diagonal]
    end

    def get_top_left_bottom_right_diagonal
      get_rows.select.with_index.map { |row, i| row[i] }.to_a
    end

    def get_top_right_bottom_left_diagonal
      get_rows.select.with_index.map { |row, i| row.reverse[i] }.to_a
    end
  end
end
