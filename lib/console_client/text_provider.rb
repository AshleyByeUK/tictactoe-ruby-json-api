module ConsoleClient
  class TextProvider
    def get_text(text, options = {})
      case text
      when 1
        'Player 1'
      when 2
        'Player 2'
      when :title
        welcome_text
      when :help
        "Type 'quit' at any time to exit TicTacToe."
      when :main_menu
        "1. Play a game.\n2. Quit."
      when :configure_player
        "Choose a player type for #{get_text(options[:player])}:\n\n1. Human.\n2. Easy computer."
      when :return_to_main_menu
        "Return to main menu? (Y/N)"
      when :invalid_selection
        'That option was not recognised, please try again.'
      when :ready
        ''
      when :ok
        'Good move.'
      when :bad_position
        "You can't place a token there. Try again."
      when :win
        "GAME OVER! #{get_text(options[:player])} won!"
      when :tie
        "GAME OVER! It's a tie."
      when :quit
        'Thanks for playing TicTacToe.'
      else
        'Sorry, something unexpected occurred.'
      end
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
  end
end
