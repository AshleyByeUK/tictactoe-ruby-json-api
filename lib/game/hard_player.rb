module Game
  class HardPlayer
    attr_reader :name, :token

    def initialize(token, name)
      @token = token
      @name = name
    end

    def make_move(game, ui = nil)
      find_best_move(game)
    end

    def find_best_move(game)
      @other_token = game.other_players_token
      @rules = game.rules

      best_score = -1000
      best_move = -1

      board = game.current_board
      board.available_positions.each do |position|
        b = board.place_token(position, @token)
        score = minimax(b, 0, false, -1000, 1000)
        if (score > best_score)
          best_score = score
          best_move = position
        end
      end
      best_move
    end

    def minimax(board, depth, is_maximising, alpha, beta)
      return score(board, depth) if @rules.game_over?(board) || depth >= 5

      if is_maximising
        maximise(board, depth, is_maximising, alpha, beta)
      else
        minimise(board, depth, is_maximising, alpha, beta)
      end
    end

    def maximise(board, depth, is_maximising, alpha, beta)
      max_score = -1000
      board.available_positions.each do |position|
        b = board.place_token(position, @token)
        score = minimax(b, depth + 1, false, alpha, beta)
        max_score = [max_score, score].max
        alpha = [max_score, alpha].max
        break if beta <= alpha
      end
      max_score
    end

    def minimise(board, depth, is_maximising, alpha, beta)
      min_score = 1000
      board.available_positions.each do |position|
        b = board.place_token(position, @other_token)
        score = minimax(b, depth + 1, true, alpha, beta)
        min_score = [min_score, score].min
        beta = [min_score, beta].min
        break if beta <= alpha
      end
      min_score
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
