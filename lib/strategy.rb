require 'easy_strategy'
require 'human_strategy'

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

