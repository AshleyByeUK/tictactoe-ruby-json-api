module Game
  class HumanPlayer
    attr_reader :name, :token, :type

    def initialize(token, name)
      @token = token
      @name = name
      @type = :human
    end

    def get_move(game, ui)
      ui.listen_for_user_input(game).to_i
    end
  end
end
