module Game
  class GameRules
    def game_over?(board)
      win?(board) || tie?(board)
    end

    def game_result(board)
      game_over?(board) ? game_over_reason(board) : :playing
    end

    private

    def win?(board)
      p = board.positions
      winning_combination?(p[0], p[1], p[2]) ||
        winning_combination?(p[3], p[4], p[5]) ||
        winning_combination?(p[6], p[7], p[8]) ||
        winning_combination?(p[0], p[3], p[6]) ||
        winning_combination?(p[1], p[4], p[7]) ||
        winning_combination?(p[2], p[5], p[8]) ||
        winning_combination?(p[0], p[4], p[8]) ||
        winning_combination?(p[2], p[4], p[6])
    end

    def winning_combination?(a, b, c)
      a == b && b == c
    end

    def tie?(board)
      board.available_positions.empty?
    end

    def game_over_reason(board)
      win?(board) ? :win : :tie
    end
  end
end
