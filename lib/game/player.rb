require 'game/easy_player'
require 'game/hard_player'
require 'game/human_player'

module Game
  class Player
    def self.create(type, token, name)
      case type
      when :human
        HumanPlayer.new(token, name)
      when :easy
        EasyPlayer.new(token, name)
      when :hard
        HardPlayer.new(token, name)
      else
        raise RuntimeError, "Unknown player type specified"
      end
    end
  end
end
