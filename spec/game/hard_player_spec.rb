require 'game/board'
require 'game/game'
require 'game/hard_player'

module Game
  describe HardPlayer do
    1.times do
      before(:each) do
        player_one = HardPlayer.new('X', 'Player 1')
        player_two = HardPlayer.new('O', 'Player 2')
        @players = [player_one, player_two]
      end

      it "chooses the tie position when only one position remains" do
        board = Board.new(3, ['X', 'X', 'O', 'O', 'O', 6, 'X', 'O', 'X'])
        game = Game.new(@players, board: board)
                  .make_move
        expect(game.tie?).to be true
        expect(game.current_board).to eq Board.new(3, ['X', 'X', 'O', 'O', 'O', 'X', 'X', 'O', 'X'])
      end

      it "chooses the win position when only one position remains" do
        board = Board.new(3, ['X', 'X', 'O', 'X', 'X', 'O', 'O', 'O', 9])
        game = Game.new(@players, board: board)
                  .make_move
        expect(game.win?).to be true
        expect(game.current_board).to eq Board.new(3, ['X', 'X', 'O', 'X', 'X', 'O', 'O', 'O', 'X'])
      end

      it "chooses the win position when two positions remain" do
        board = Board.new(3, ['X', 'O', 'X', 'X', 'O', 'O', 7, 8, 'O'])
        game = Game.new(@players, board: board)
                  .make_move
        expect(game.win?).to be true
        expect(game.current_board).to eq Board.new(3, ['X', 'O', 'X', 'X', 'O', 'O', 'X', 8, 'O'])
      end

      it "blocks the opponent from winning" do
        board = Board.new(3, [1, 'X', 'O', 'X', 'O', 6, 7, 8, 9])
        game = Game.new(@players, board: board)
                  .make_move
        expect(game.game_over?).to be false
        expect(game.current_board).to eq Board.new(3, [1, 'X', 'O', 'X', 'O', 6, 'X', 8, 9])
      end

      it "also blocks the opponent from winning" do
        board = Board.new(3, ['X', 2, 3, 4, 'O', 'O', 7, 8, 9])
        game = Game.new(@players, board: board)
                  .make_move
        expect(game.game_over?).to be false
        expect(game.current_board).to eq Board.new(3, ['X', 2, 3, 'X', 'O', 'O', 7, 8, 9])
      end

      it "plays for a winning move" do
        board = Board.new(3, ['X', 2, 'X', 'O', 'O', 6, 7, 'X', 'O'])
        game = Game.new(@players, board: board)
                  .make_move
        expect(game.win?).to be true
        expect(game.current_board).to eq Board.new(3, ['X', 'X', 'X', 'O', 'O', 6, 7, 'X', 'O'])
      end

      it "plays for a forking move" do
        board = Board.new(3, [1, 'X', 3, 4, 5, 'O', 7, 'O', 'X'])
        game = Game.new(@players, board: board, current_player: 1)
                  .make_move
        expect(game.game_over?).to be false
        expect(game.current_board).to eq Board.new(3, ['X', 'X', 3, 4, 5, 'O', 7, 'O', 'X'])
      end
    end

    # it "computes a move for an empty 3x3 board in no more than 200ms" do
    #   game = Game.new(@players)
    #   start = Time.now
    #   game = game.make_move
    #   finish = Time.now
    #   duration_ms = ((finish - start) * 1000).to_i
    #   expect(duration_ms).to be <= 200
    #   expect(game.available_positions.length).to eq 8
    # end

    # it "computes a move for an empty 4x4 board in no more than 200ms" do
    #   game = Game.new(@players, board_size: 4)
    #   start = Time.now
    #   game = game.make_move
    #   finish = Time.now
    #   duration_ms = ((finish - start) * 1000).to_i
    #   expect(duration_ms).to be <= 200
    #   expect(game.available_positions.length).to eq 15
    # end
  end
end
