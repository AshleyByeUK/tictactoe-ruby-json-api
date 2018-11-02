module Game
  class HumanPlayer
    attr_reader :type, :token

    def initialize(token, user_interface)
      @user_interface = user_interface
      @type = :user
      @token = token
    end

    def compute_move(game)
      @user_interface.get_move(game).to_i
    end
  end
end
