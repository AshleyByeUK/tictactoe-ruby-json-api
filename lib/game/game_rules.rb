module Game
  class GameRules
    def initialize(board)
      @winning_indices = board.compute_winning_indices
    end

    def game_over?(board)
      win?(board) || tie?(board)
    end

    def game_result(board)
      game_over?(board) ? game_over_reason(board) : :playing
    end

    def winner?(board, token)
      win?(board) && @winner == token
    end

    private

    def win?(board)
      win = false
      unless enough_made_moves_for_a_win?(board)
        possible_winning_positions(board).each do |combination|
          win = winning_combination?(combination)
          @winner = winning_player(combination) if win
          break if win
        end
      end
      win
    end

    def enough_made_moves_for_a_win?(board)
      board.available_positions.length > board.positions.length - ((2 * board.size) - 1)
    end

    def possible_winning_positions(board)
      @winning_indices.map { |i| board.positions[i] }.each_slice(board.size).to_a
    end

    def winning_combination?(combination)
      combination.uniq.length == 1
    end

    def winning_player(winning_combination)
      winning_combination[0]
    end

    def tie?(board)
      board.available_positions.empty?
    end

    def game_over_reason(board)
      win?(board) ? :win : :tie
    end
  end
end
