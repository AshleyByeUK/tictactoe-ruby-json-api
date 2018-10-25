class DecisionEngine
  def game_over?(board)
    win?(board) || tie?(board)
  end

  def result(board)
    game_over?(board) ? game_result(board) : :playing
  end

  private

  def win?(board)
    p = board.positions
    equal_not_empty?(p[0], p[1], p[2]) ||
      equal_not_empty?(p[3], p[4], p[5]) ||
      equal_not_empty?(p[6], p[7], p[8]) ||
      equal_not_empty?(p[0], p[3], p[6]) ||
      equal_not_empty?(p[1], p[4], p[7]) ||
      equal_not_empty?(p[2], p[5], p[8]) ||
      equal_not_empty?(p[0], p[4], p[8]) ||
      equal_not_empty?(p[2], p[4], p[6])
  end

  def equal_not_empty?(a, b ,c)
    a == b && b == c && a != -1
  end

  def tie?(board)
    board.available_positions.length == 0
  end

  def game_result(board)
    win?(board) ? :win : :tie
  end
end
