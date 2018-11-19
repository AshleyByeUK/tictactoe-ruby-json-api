module Game
  class EasyPlayer
    attr_reader :name, :token, :type

    def initialize(token, name)
      @token = token
      @name = name
      @type = :easy
    end

    def get_move(game, ui = nil)
      game.available_positions.sample
    end
  end
end
