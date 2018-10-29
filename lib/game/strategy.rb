require 'game/easy_strategy'
require 'game/human_strategy'

module Game
  class Strategy
    def self.create(name)
      case name
      when :human
        HumanStrategy.new()
      when :easy
        EasyStrategy.new()
      else
        raise RuntimeError, "Unknown strategy name specified"
      end
    end
  end
end
