module Game
  class MockGameUI
    attr_reader :show_game_state_called, :listen_for_user_input_called, :show_game_result_called

    def initialize
      @show_game_state_called = 0
      @listen_for_user_input_called = 0
      @show_game_result_called = 0
    end

    def show_game_state(game)
      @show_game_state_called += 1
    end

    def listen_for_user_input(game)
      @listen_for_user_input_called += 1
    end

    def show_game_result(game)
      @show_game_result_called += 1
    end
  end
end
