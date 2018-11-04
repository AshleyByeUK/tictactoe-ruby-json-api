require 'game/player'

module Game
  describe Player do
    before(:each) do
      @token = 'X'
      @name = 'Player'
    end

    it "creates a human player" do
      player = Player.create(:human, @token, @name)
      expect(player.is_a?(HumanPlayer)).to be true
      expect(player.token).to eq @token
      expect(player.name).to eq @name
    end

    it "creates an easy computer player" do
      player = Player.create(:easy, @token, @name)
      expect(player.is_a?(EasyPlayer)).to be true
      expect(player.token).to eq @token
      expect(player.name).to eq @name
    end

    it "creates a hard computer player" do
      player = Player.create(:hard, @token, @name)
      expect(player.is_a?(HardPlayer)).to be true
      expect(player.token).to eq @token
      expect(player.name).to eq @name
    end

    it "raises an unknown player error when an invalid player is provided" do
      expect { Player.create(:unknown, @token, @name) }.to raise_exception(RuntimeError, "Unknown player type specified")
    end
  end
end
