module Game
  class HumanPlayer
    attr_reader :type, :token

    def initialize(token)
      @type = :user
      @token = token
    end

    def compute_move(game, ui)
      ui.listen_for_user_input(game).to_i
    end
  end
end
