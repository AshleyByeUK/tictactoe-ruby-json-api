require 'rspec'
require 'setup'

describe Setup do
  it "passes" do
    expect(Setup.new().check()).to eq true
  end
end
