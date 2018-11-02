require 'game/easy_player'
require 'game/hard_player'
require 'game/human_player'

module Game
  class Player
    def self.create(name, token, io)
      case name
      when :human
        HumanPlayer.new(token, io)
      when :easy
        EasyPlayer.new(token)
      when :hard
        HardPlayer.new(token)
      else
        raise RuntimeError, "Unknown player type specified"
      end
    end
  end
end
