require 'rspec'
require 'game/strategy'

module Game
  describe Strategy do
    it "creates a human strategy" do
      strategy = Strategy.create(:human)
      expect(strategy.name).to eq :human
      expect(strategy.type).to eq :user
    end

    it "creates an easy computer strategy" do
      strategy = Strategy.create(:easy)
      expect(strategy.name).to eq :easy
      expect(strategy.type).to eq :computer
    end

    it "raises an unknown strategy error when an invalid strategy is provided" do
      expect { Strategy.create(:unknown) }.to raise_exception(RuntimeError, "Unknown strategy name specified")
    end
  end
end
