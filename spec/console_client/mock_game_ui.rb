module ConsoleClient
  class MockGameUI
    attr_reader :show_game_state_called, :get_move_called,
      :show_invalid_position_message_called, :show_game_result_called

    def initialize
      @show_game_state_called = 0
      @get_move_called = 0
      @show_invalid_position_message_called = 0
      @show_game_result_called = 0
    end

    def show_game_state(game)
      @show_game_state_called += 1
    end

    def get_move(game)
      @get_move_called += 1
    end

    def show_invalid_position_message
      @show_invalid_position_message_called += 1
    end

    def show_game_result(game)
      @show_game_result_called += 1
    end
  end
end
