require 'rspec'
require 'game/easy_strategy'
require 'game/board'

module Game
  describe EasyStrategy do
    it "picks a random position from available positions" do
      board = Board.new([ONE, TWO, ONE, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY])
      easy = EasyStrategy.new()
      move = easy.compute_move(board)
      expect(board.available_positions).to include(move)
    end
  end
end
