class HumanStrategy
  attr_reader :name, :type

  def initialize()
    @name = :human
    @type = :user
  end

  def compute_move(board, position)
    position
  end
end

