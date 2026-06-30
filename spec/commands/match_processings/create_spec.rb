require "rails_helper"

RSpec.describe MatchProcessings::Create do
  describe "#call" do
    subject(:command_call) { described_class.call(match:) }

    let(:match) { create(:match) }

    it "delegates to Bonuses::Cashier with the match" do
      allow(Bonuses::Cashier).to receive(:call).and_return(:result)

      expect(command_call).to eq(:result)
      expect(Bonuses::Cashier).to have_received(:call).with(match:)
    end
  end
end
