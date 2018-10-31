require 'game/easy_player'
require 'game/human_player'

module Game
  class Player
    def self.create(name, token)
      case name
      when :human
        HumanPlayer.new(token)
      when :easy
        EasyPlayer.new(token)
      else
        raise RuntimeError, "Unknown player type specified"
      end
    end
  end
end
