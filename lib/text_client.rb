require 'game'

class TextClient
  def start
    game = Game.new()
    play(game) if game.state == :ready
  end

  private

  def play(game)
    while game.state != :game_over
      update_ui(game)
      move = get_next_move(game.current_player)
      game = game.make_move(game.current_player, move)
    end
    update_ui(game)
    :finished
  end

  def update_ui(game)
    print_game_state(game.state, game.result, game.current_player) if game.state == :ready
    print_board(game.board_state)
    print_game_state(game.state, game.result, game.current_player) unless game.state == :ready
    print_available_positions(game.available_positions) unless game.state == :game_over
    print_get_next_move_prompt(game.current_player) unless game.state == :game_over
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

  def print_game_state(state, result, current_player)
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
             "GAME OVER! #{game_over_reason(result, current_player)}\n\n"
           else
             ""
           end
    puts "\n#{text}"
  end

  def game_over_reason(result, current_player)
    result == :tie ? "It's a tie." : "#{player_text(current_player)} won!"
  end

  def print_available_positions(positions)
    print "\nAvailable positions: "
    positions.each { |p| print "#{p} " }
    print "\n"
  end

  def print_get_next_move_prompt(player)
    print "\nMake a move, #{player_text(player)} > "
  end

  def player_text(player)
    player == :player_one ? "Player 1" : "Player 2"
  end

  def get_next_move(player)
    gets
  end
end

