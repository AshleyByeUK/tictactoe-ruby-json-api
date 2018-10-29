require 'rspec'
require 'rspec/mocks'
require 'text_client'
require 'text_client_game'
require 'game'

HUMAN = '1'
EASY = '2'
QUIT = 'quit'
RETURN = "\n"
ONE = 0
TWO = 1
THREE = 2
FOUR = 3
FIVE = 4

describe TextClient do
  before(:all) do
    @original_stdout = $stdout
    @original_stderr = $stderr
    $stdout = File.open(File::NULL, 'w')
    $stderr = File.open(File::NULL, 'w')
  end

  before(:each) do
    @client = TextClient.new
  end

  after(:all) do
    $stdout = @original_stdout
    $stderr = @original_stderr
    @original_stdout = nil
    @original_stderr = nil
  end

  context "human vs human" do
    before(:each) do
      allow(@client).to receive(:gets).and_return(RETURN, HUMAN, HUMAN, QUIT)
    end

    it "can start and end a game" do
      allow_any_instance_of(TextClientGame).to receive(:gets).and_return(ONE, FOUR, TWO, FIVE, THREE)
      expect(@client.start).to eq :finished
    end

    it "does not change player when invalid input is entered" do
      allow_any_instance_of(TextClientGame).to receive(:gets).and_return(ONE, 'BAD', FOUR, TWO, FIVE, THREE)
      expect(@client.start).to eq :finished
    end

    it "does not change player when a duplicate position is given" do
      allow_any_instance_of(TextClientGame).to receive(:gets).and_return(ONE, ONE, FOUR, TWO, FIVE, THREE)
      expect(@client.start).to eq :finished
    end
  end

  context "computer vs computer" do
    before(:each) do
      allow(@client).to receive(:gets).and_return(RETURN, EASY, EASY, QUIT)
    end

    it "can play until a tie or win is achieved" do
      expect(@client.start).to eq :finished
    end
  end
end
