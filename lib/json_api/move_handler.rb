module JsonAPI
  class MoveHandler
    def initialize(request)
      @request = request
    end

    def get_move(game)
      raise DeserializationError.new("missing player's move") if missing_move?
      @request.dig('move', 'position')
    end

    private

    def missing_move?
      !@request.has_key?('move') ||
        !@request['move'].has_key?('position') ||
        !@request.dig('move', 'position') == nil
    end
  end
end
