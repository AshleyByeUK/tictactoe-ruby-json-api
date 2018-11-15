module Game
  class MockPlayer
    attr_reader :token

    def initialize(token, *moves)
      @token = token
      @moves = moves.flatten
    end

    def get_move(game, ui)
      ui.get_move(game)
      @moves.pop
    end

    def name
      'Mock Player'
    end
  end
end
