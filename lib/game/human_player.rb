module Game
  class HumanPlayer
    attr_reader :name, :type, :token

    def initialize(token)
      @name = :human
      @type = :user
      @token = token
    end

    def compute_move(board, position)
      position
    end
  end
end
