module Game
  class HardPlayer
    attr_reader :type, :token

    def initialize(token)
      @type = :computer
      @token = token
    end

    def compute_move(game)
      @me = game.current_player
      minimax(game)
      @position
    end

    def minimax(game)
      return score(game) if game.game_over?

      scores = []
      positions = []

      game.available_positions.each do |position|
        g = game.place_token(game.current_player, position)
        scores << minimax(g)
        positions << position
      end

      if game.current_player == @me
        index = scores.select.with_index.max[1]
        @position = positions[index]
        scores[index]
      else
        index = scores.select.with_index.min[1]
        @position = positions[index]
        scores[index]
      end
    end

    def score(game)
      if game.win? && game.last_player == @me
        100
      elsif game.win? && game.last_player != @me
        -100
      else
        0
      end
    end
  end
end
