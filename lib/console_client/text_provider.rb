module ConsoleClient
  module TextProvider
    TITLE = " _______ _   _______      _______          \n" +
      "|__   __(_) |__   __|    |__   __|         \n" +
      "   | |   _  ___| | __ _  ___| | ___   ___  \n" +
      "   | |  | |/ __| |/ _` |/ __| |/ _ \\ / _ \\ \n" +
      "   | |  | | (__| | (_| | (__| | (_) |  __/ \n" +
      "   |_|  |_|\\___|_|\\__,_|\\___|_|\\___/ \\___| \n\n\n"
    HELP = "Type 'quit' or 'ctrl-c' to exit."
    MAIN_MENU = "1. Play a game (3x3).\n2. Play a game (4x4).\n3. Quit."
    PLAYER_TYPE = "Choose a player type:\n\n1. Human.\n2. Easy computer.\n3. Hard computer."
    RETURN_TO_MAIN_MENU = "Return to main menu? (Y/N)"
    INVALID_SELECTION = 'That option was not recognised, please try again.'
    GOOD_MOVE = 'Good move.'
    BAD_MOVE = "You can't place a token there. Try again."
    GAME_OVER = 'GAME OVER!'
    WIN = "won!"
    TIE = "It's a tie."
    QUIT = 'Thanks for playing TicTacToe.'
  end
end
