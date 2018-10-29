class TextProvider
  def get_text(text, options = {})
    case text
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
      "GAME OVER! #{game_over_reason(options[:result], options[:player])}\n\n"
    when :welcome
      welcome_text
    when :player_type
      "Choose a player type for #{player_text(options[:player])}:\n\n1. Human\n2. Easy computer\n"
    when :play_a_game
      "Play a game of TicTacToe. Press any key to continue or type 'quit' to exit."
    else
      "Oops. An unexpected event occurred."
    end
  end

  def player_text(player)
    player == :player_one ? "Player 1" : "Player 2"
  end

  private

  def welcome_text
    " _______ _   _______      _______          \n" +
    "|__   __(_) |__   __|    |__   __|         \n" +
    "   | |   _  ___| | __ _  ___| | ___   ___  \n" +
    "   | |  | |/ __| |/ _` |/ __| |/ _ \\ / _ \\ \n" +
    "   | |  | | (__| | (_| | (__| | (_) |  __/ \n" +
    "   |_|  |_|\\___|_|\\__,_|\\___|_|\\___/ \\___| \n\n\n"
  end

  def game_over_reason(result, player)
    result == :tie ? "It's a tie." : "#{player_text(player)} won!"
  end
end
