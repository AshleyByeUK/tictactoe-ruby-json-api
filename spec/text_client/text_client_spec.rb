require 'text_client/text_client'
require 'game/game'

module TextClient
  HUMAN = '1'
  EASY = '2'
  QUIT = 'quit'
  RETURN = "\n"

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

    it "exits when 'quit' is typed in main menu" do
      allow_any_instance_of(TextClient).to receive(:gets).and_return('quit')
      expect(@client.start).to eq :finished
    end

    it "ignores case and exits when 'QUIT' is typed in main menu" do
      allow_any_instance_of(TextClient).to receive(:gets).and_return('QUIT')
      expect(@client.start).to eq :finished
    end

    context "human vs human" do
      it "can start and end a game" do
        allow_any_instance_of(TextClient).to receive(:gets).and_return(RETURN, HUMAN, HUMAN, '0', '3', '1', '4', '2', QUIT)
        expect(@client.start).to eq :finished
      end

      it "does not change player when invalid input is entered" do
        allow_any_instance_of(TextClient).to receive(:gets).and_return(RETURN, HUMAN, HUMAN, '0', 'BAD', '3', '1', '4', '2', QUIT)
        expect(@client.start).to eq :finished
      end

      it "does not change player when a duplicate position is given" do
        allow_any_instance_of(TextClient).to receive(:gets).and_return(RETURN, HUMAN, HUMAN, '0', '0', '3', '1', '4', '2', QUIT)
        expect(@client.start).to eq :finished
      end
    end

    context "computer vs computer" do
      before(:each) do
        allow_any_instance_of(TextClient).to receive(:gets).and_return(RETURN, EASY, EASY, QUIT)
      end

      it "can play until a tie or win is achieved" do
        expect(@client.start).to eq :finished
      end
    end

    context "getting user input" do
      [
        [['q'], 'q'],
        [['q', 'quit'], 'quit'],
        [['q', 'quit'], 'QUIT'],
        [['q', 'quit'], '  quit  '],
        [['q', 'quit', 'exit'], 'exit']
      ].each do |test|
        commands, quit = test
        it "informs when a valid '#{quit}' command is given" do
          allow(@client).to receive(:gets).and_return(quit)
          expect(@client.get_input()).to eq :exit
        end
      end

      [
        [[], ''],
        [['y'], 'u', 'y'],
        [['y', 'n'], 'u', 'n'],
        [[0, 1, 2, 3, 4], '6', '1'],
      ].each do |test|
        valid_input, *attempts = test
        it "continues to get input until valid input has been given" do
          allow(@client).to receive(:gets).and_return(*attempts)
          expect(@client.get_input(valid_input)).to eq attempts[attempts.length - 1]
        end
      end
    end
  end
end
