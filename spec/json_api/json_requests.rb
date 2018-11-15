module JsonAPI
  module JsonRequests
    def self.empty_json_object
      '{}'
    end

    def self.invalid_new_game_only_one_player
      '{
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          }
        }
      }'
    end

    def self.invalid_new_game_missing_player_info
      '{
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'
    end

    def self.valid_new_game
      '{
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'
    end

    def self.valid_new_game_board_size_4
      '{
        "game": {
          "board_size": 4
        },
        "players": {
          "player_one": {
            "name": "Player 1",
            "token": "X",
            "type": "human"
          },
          "player_two": {
            "name": "Player 2",
            "token": "O",
            "type": "human"
          }
        }
      }'
    end

    def self.valid_human_game_is_over
      '{
        "game": {
          "board": ["X", "X", "X", "X", "O", "O", "O", 8, 9, 10, 11, 12, 13, 14, 15, 16],
          "current_player": 2,
          "state": "playing"
        },
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.valid_computer_game_is_over
      '{
        "game": {
          "board": ["X", "X", "X", "O", "O", 6, 7, 8, 9],
          "current_player": 2,
          "state": "playing"
        },
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "easy"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "easy"
          }
        }
      }'
    end

    def self.invalid_game_no_players
      '{
        "game": {
          "board": ["X", "X", 3, "O", "O", 6, 7, 8, 9],
          "current_player": 1,
          "state": "playing"
        }
      }'
    end

    def self.invalid_game_no_human_move_given
      '{
        "game": {
          "board": ["X", "X", 3, "O", "O", 6, 7, 8, 9],
          "current_player": 1,
          "state": "playing"
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.invalid_game_invalid_move_given
      '{
        "game": {
          "board": ["X", "X", 3, "O", "O", 6, 7, 8, 9],
          "current_player": 1,
          "state": "playing"
        },
        "move": {
          "position": 1
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.valid_game_computers_move
      '{
        "game": {
          "board": ["X", 2, "X", "O", "O", 6, 7, 8, 9],
          "current_player": 1,
          "state": "playing"
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "easy"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "hard"
          }
        }
      }'
    end

    def self.invalid_game_missing_game_info
      '{
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.invalid_game_missing_board
      '{
        "game": {
          "current_player": 1,
          "state": "playing"
        },
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.invalid_game_missing_current_player
      '{
        "game": {
          "board": ["X", 2, "X", "O", "O", 6, 7, 8, 9],
          "state": "playing"
        },
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.invalid_game_missing_state
      '{
        "game": {
          "board": ["X", 2, "X", "O", "O", 6, 7, 8, 9],
          "current_player": 1
        },
        "move": {
          "position": 6
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end

    def self.valid_game_human_move
      '{
        "game": {
          "board": ["X", 2, "X", "O", "O", 6, 7, 8, 9],
          "current_player": 1,
          "state": "playing"
        },
        "move": {
          "position": 2
        },
        "players": {
          "player_one": {
              "name": "Player 1",
              "token": "X",
              "type": "human"
          },
          "player_two": {
              "name": "Player 2",
              "token": "O",
              "type": "human"
          }
        }
      }'
    end
  end
end
