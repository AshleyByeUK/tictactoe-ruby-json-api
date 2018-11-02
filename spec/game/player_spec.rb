require 'game/player'
require 'game/mock_user_interface'

module Game
  describe Player do
    before(:all) do
      @user_interface = MockUserInterface.new
    end

    it "creates a human player" do
      player = Player.create(:human, 'X', @user_interface)
      expect(player.type).to eq :user
    end

    it "creates an easy computer player" do
      player = Player.create(:easy, 'X', @user_interface)
      expect(player.type).to eq :computer
    end

    it "creates a hard computer player" do
      player = Player.create(:hard, 'X', @user_interface)
      expect(player.type).to eq :computer
    end

    it "raises an unknown player error when an invalid player is provided" do
      expect { Player.create(:unknown, 'X', @user_interface) }.to raise_exception(RuntimeError, "Unknown player type specified")
    end
  end
end
