require 'game/easy_player'
require 'game/board'
require 'game/game'

module Game
  describe EasyPlayer do
    it "picks a random position from available positions" do
      board = Board.new(3, ['X', 'O', 'X', *3..8])
      game = Game.new(board)
      easy = EasyPlayer.new('O', 'Player 1')
      move = easy.make_move(game)
      expect(game.available_positions).to include(move)
    end
  end
end
