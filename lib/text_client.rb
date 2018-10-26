require 'game'

class TextClient
  def initialize()
    @current_player = :player_one
  end

  def start
    game = Game.new()
    play(game) if game.state == :ready
    :finished
  end

  private

  def play(game)
    while game.state != :game_over
      update_ui(game)
      move = get_next_move(@current_player)
      game = game.make_move(@current_player, move)
      swap_current_player if game.state == :ok
    end
    update_ui(game)
  end

  def update_ui(game)
    print_game_state(game.state, game.result) if game.state == :ready
    print_board(game.board_state)
    print_game_state(game.state, game.result) unless game.state == :ready
    print_available_positions(game.available_positions) unless game.state == :game_over
    print_get_next_move_prompt(@current_player) unless game.state == :game_over
  end

  def print_board(board)
    puts ""
    draw_row(board[0], board[1], board[2])
    draw_spacer_row
    draw_row(board[3], board[4], board[5])
    draw_spacer_row
    draw_row(board[6], board[7], board[8])
  end

  def draw_row(a, b, c)
    puts " #{marker_for(a)} | #{marker_for(b)} | #{marker_for(c)} "
  end

  def marker_for(id)
    case id
    when 1
      "X"
    when 2
      "O"
    else
      " "
    end
  end

  def draw_spacer_row
    puts '-----------'
  end

  def print_game_state(state, result)
    text = case state
           when :ready
             "Great, let's play a game of Tic Tac Toe!"
           when :ok
             "Good move."
           when :wrong_player
             "Hmm, it seem's like the wrong player took a turn."
           when :invalid_player
             "Hmm, it seems like an invalid player was specified."
           when :invalid_position
             "Hmm, that position doesn't exist. Try again."
           when :position_taken
             "Hmm, you can't play on top of an existing marker. Try again."
           when :game_over
             "GAME OVER! #{game_over_reason(result)}"
           else
             ""
           end
    puts "\n#{text}"
  end

  def game_over_reason(result)
    result == :tie ? "It's a tie." : "#{@current_player} won!"
  end

  def print_available_positions(positions)
    puts "\nAvailable positions: #{positions}"
  end

  def print_get_next_move_prompt(player)
    print "\nMake a move, #{player} > "
  end

  def get_next_move(player)
    gets
  end

  def swap_current_player
    @current_player = @current_player == :player_one ? :player_two : :player_one
  end
end

