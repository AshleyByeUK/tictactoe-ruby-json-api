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

    def get_rows
      @positions.each_slice(@size).to_a
    end

    def ==(other)
      @positions == other.positions
    end

    def compute_winning_indices
      row_indices = compute_row_indices
      column_indices = compute_column_indices(row_indices)
      diagonal_indices = compute_diagonal_indices(row_indices)
      row_indices
          .concat(column_indices)
          .concat(diagonal_indices)
          .flatten
    end

    private

    def compute_row_indices
      @positions.select.with_index.map { |p, i| i }.each_slice(@size).to_a
    end

    def compute_column_indices(row_indices)
      row_indices.transpose
    end

    def compute_diagonal_indices(row_indices)
      compute_top_left_bottom_right_diagonal(row_indices)
          .concat(compute_top_right_bottom_left_diagonal(row_indices))
    end

    def compute_top_left_bottom_right_diagonal(row_indices)
      row_indices.select.with_index.map { |row, i| row[i] }.to_a
    end

    def compute_top_right_bottom_left_diagonal(row_indices)
      row_indices.select.with_index.map { |row, i| row.reverse[i] }.to_a
    end
  end
end
