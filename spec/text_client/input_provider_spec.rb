require 'rspec'
require 'text_client/input_provider'

module TextClient
  describe InputProvider do
    before(:all) do
      @original_stdout = $stdout
      @original_stderr = $stderr
      $stdout = File.open(File::NULL, 'w')
      $stderr = File.open(File::NULL, 'w')
    end

    after(:all) do
      $stdout = @original_stdout
      $stderr = @original_stderr
      @original_stdout = nil
      @original_stderr = nil
    end

    [
      [['q'], 'q'],
      [['q', 'quit'], 'quit'],
      [['q', 'quit'], 'QUIT'],
      [['q', 'quit'], '  quit  '],
      [['q', 'quit', 'exit'], 'exit']
    ].each do |test|
      commands, quit = test
      it "informs when a valid '#{quit}' command is given" do
        input = InputProvider.new(commands)
        allow(input).to receive(:gets).and_return(quit)
        expect(input.get_input()).to eq :exit
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
        input = InputProvider.new(['q'])
        allow(input).to receive(:gets).and_return(*attempts)
        expect(input.get_input(valid_input)).to eq attempts[attempts.length - 1]
      end
    end
  end
end
