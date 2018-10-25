require 'rspec'
require 'board'
require 'decision_engine'

describe DecisionEngine do
  before(:each) do
    @one = Board::PLAYER_ONE
    @two = Board::PLAYER_TWO
    @empty = Board::AVAILABLE_POSITION
    @decision_engine = DecisionEngine.new()
  end

  it "is game over with a tie if no winning combination is played" do
    positions = [@one, @two, @one, @one, @two, @two, @two, @one, @one]
    board = Board.new(positions)
    expect(@decision_engine.game_over?(board)).to be true
    expect(@decision_engine.result(board)).to eq :tie
  end

  it "is not game over when no win and no tie" do
    board = Board.new()
    expect(@decision_engine.game_over?(board)).to be false
    expect(@decision_engine.result(board)).to eq :playing
  end

  it "is game over with a win when a winning combination is played" do
    [
      [@one, @one, @one, @empty, @empty, @empty, @empty, @empty, @empty],
      [@empty, @empty, @empty, @one, @one, @one, @empty, @empty, @empty],
      [@empty, @empty, @empty, @empty, @empty, @empty, @two, @two, @two],
      [@one, @two, @empty, @one, @two, @empty, @one, @empty, @empty],
      [@empty, @one, @two, @empty, @one, @two, @empty, @one, @empty],
      [@empty, @two, @one, @empty, @two, @one, @empty, @empty, @one],
      [@one, @empty, @empty, @empty, @one, @empty, @empty, @empty, @one],
      [@empty, @empty, @one, @empty, @one, @empty, @one, @empty, @empty]
    ].each do |positions|
      board = Board.new(positions)
      expect(@decision_engine.game_over?(board)).to be true
      expect(@decision_engine.result(board)).to be :win
    end
  end

  it "does not declare a win on final move to be a tie" do
    positions = [@one, @two, @one, @two, @one, @one, @two, @two, @one]
    board = Board.new(positions)
    expect(@decision_engine.game_over?(board)).to be true
    expect(@decision_engine.result(board)).to eq :win
  end
end
