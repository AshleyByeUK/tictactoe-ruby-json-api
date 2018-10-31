module Game
  class EasyPlayer
    attr_reader :name, :type, :token

    def initialize(token)
      @name = :easy
      @type = :computer
      @token = token
    end

    def compute_move(board, position = nil)
      board.available_positions.sample
    end
  end
end
