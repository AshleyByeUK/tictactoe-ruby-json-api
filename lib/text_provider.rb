class TextProvider
  def get_text(state, result, player)
    case state
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
      "GAME OVER! #{game_over_reason(result, player)}\n\n"
    else
      "Oops. An unexpected event occurred."
    end
  end

  def player_text(player)
    player == :player_one ? "Player 1" : "Player 2"
  end

  private

  def game_over_reason(result, player)
    result == :tie ? "It's a tie." : "#{player_text(player)} won!"
  end
end

