class EasyStrategy
  attr_reader :name, :type

  def initialize()
    @name = :easy
    @type = :computer
  end

  def compute_move(board, position = nil)
    board.available_positions.sample
  end
end

