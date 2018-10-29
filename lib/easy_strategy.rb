class EasyStrategy
  def compute_move(board)
    board.available_positions.sample
  end
end
