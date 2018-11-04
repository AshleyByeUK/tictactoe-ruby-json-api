module Game
  class MockPlayer
    attr_reader :token

    def initialize(token, *moves)
      @token = token
      @moves = moves.flatten
    end

    def compute_move(game, ui)
      ui.listen_for_user_input(game)
      @moves.pop
    end
  end
end
