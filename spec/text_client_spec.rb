require 'rspec'
require 'rspec/mocks'
require 'text_client'
require 'game'

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
    it "can start and end a game" do
      allow(@client).to receive(:gets).and_return(0, 3, 1, 4, 2)
      expect(@client.start).to eq :finished
    end

    it "does not change player when invalid input is entered" do
      allow(@client).to receive(:gets).and_return(0, 'BAD', 3, 1, 4, 2)
      expect(@client.start).to eq :finished
    end

    it "does not change player when a duplicate position is given" do
      allow(@client).to receive(:gets).and_return(0, 0, 3, 1, 4, 2)
      expect(@client.start).to eq :finished
    end
  end
end
