require 'game/easy_player'
require 'game/human_player'

module Game
  class Player
    def self.create(name)
      case name
      when :human
        HumanPlayer.new()
      when :easy
        EasyPlayer.new()
      else
        raise RuntimeError, "Unknown player type specified"
      end
    end
  end
end
