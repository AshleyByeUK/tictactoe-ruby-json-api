module Game
  class HardPlayer
    attr_reader :name, :token

    def initialize(token, name)
      @token = token
      @name = name
    end

    def make_move(game, ui = nil)
      @other_token = game.other_players_token
      @rules = game.rules
      find_best_move(game.current_board)
    end

    def find_best_move(board)
      best_score = -1000
      best_move = -1

      board.available_positions.each do |position|
        b = board.place_token(position, @token)
        score = minimax(b, 0, false)
        if (score > best_score)
          best_score = score
          best_move = position
        end
      end
      best_move
    end

    def minimax(board, depth, is_maximising)
      return score(board, depth) if @rules.game_over?(board)

      score = nil

      if is_maximising
        max_score = -1000
        board.available_positions.each do |position|
          b = board.place_token(position, @token)
          score = minimax(b, depth + 1, false)
          max_score = [max_score, score].max
          score = max_score
        end
      else
        min_score = 1000
        board.available_positions.each do |position|
          b = board.place_token(position, @other_token)
          score = minimax(b, depth + 1, true)
          min_score = [min_score, score].min
          score = min_score
        end
      end

      score
    end

    def score(board, depth)
      if @rules.winner?(board, @token)
        100 - depth
      elsif @rules.winner?(board, @other_token)
        -100 + depth
      else
        0
      end
    end
  end
end
