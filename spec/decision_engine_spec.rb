require 'rspec'
require 'board'
require 'decision_engine'

ONE = Board::PLAYER_ONE
TWO = Board::PLAYER_TWO
EMPTY = Board::AVAILABLE_POSITION

describe DecisionEngine do
  before(:each) do
    @decision_engine = DecisionEngine.new()
  end

  it "is game over with a tie if no winning combination is played" do
    positions = [ONE, TWO, ONE, ONE, TWO, TWO, TWO, ONE, ONE]
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
      [ONE, ONE, ONE, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY],
      [EMPTY, EMPTY, EMPTY, ONE, ONE, ONE, EMPTY, EMPTY, EMPTY],
      [EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, EMPTY, TWO, TWO, TWO],
      [ONE, TWO, EMPTY, ONE, TWO, EMPTY, ONE, EMPTY, EMPTY],
      [EMPTY, ONE, TWO, EMPTY, ONE, TWO, EMPTY, ONE, EMPTY],
      [EMPTY, TWO, ONE, EMPTY, TWO, ONE, EMPTY, EMPTY, ONE],
      [ONE, EMPTY, EMPTY, EMPTY, ONE, EMPTY, EMPTY, EMPTY, ONE],
      [EMPTY, EMPTY, ONE, EMPTY, ONE, EMPTY, ONE, EMPTY, EMPTY]
    ].each do |positions|
      board = Board.new(positions)
      expect(@decision_engine.game_over?(board)).to be true
      expect(@decision_engine.result(board)).to be :win
    end
  end

  it "does not declare a win on final move to be a tie" do
    positions = [ONE, TWO, ONE, TWO, ONE, ONE, TWO, TWO, ONE]
    board = Board.new(positions)
    expect(@decision_engine.game_over?(board)).to be true
    expect(@decision_engine.result(board)).to eq :win
  end
end

