require 'game/easy_player'
require 'game/board'

module Game
  describe EasyPlayer do
    it "picks a random position from available positions" do
      board = Board.new(['X', 'O', 'X', *3..8])
      easy = EasyPlayer.new('O')
      move = easy.compute_move(board)
      expect(board.available_positions).to include(move)
    end
  end
end
