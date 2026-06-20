require "rails_helper"

RSpec.describe Bonuses::Clerk do
  subject(:awards) { described_class.new(match:, score:).prepare_awards }

  let(:home) { create(:nation, name: "Франция") }
  let(:away) { create(:nation, name: "Россия") }
  let(:match) { create(:match, home:, away:) }

  before do
    stub_const("Bonuses::Boltun", double("Boltun"))
    allow(Bonuses::Boltun).to receive(:call).and_return("описание")
  end

  describe "#prepare_awards" do
    context "when home team wins" do
      let(:score) { [3, 1] }

      it "rewards home for the victory and away for the defeat", :aggregate_failures do
        expect(awards[:home]).to include(match:, nation: home, reason: :victory, value: 3)
        expect(awards[:away]).to include(match:, nation: away, reason: :defeat, value: 0)
      end

      it "asks Boltun to phrase each team's description from its own perspective", :aggregate_failures do
        awards

        expect(Bonuses::Boltun).to have_received(:call)
          .with(reason: :victory, stage: match.stage, opponent: away, score: "3:1")
        expect(Bonuses::Boltun).to have_received(:call)
          .with(reason: :defeat, stage: match.stage, opponent: home, score: "1:3")
      end
    end

    context "when away team wins" do
      let(:score) { [0, 2] }

      it "rewards away for the victory and home for the defeat", :aggregate_failures do
        expect(awards[:home]).to include(nation: home, reason: :defeat, value: 0)
        expect(awards[:away]).to include(nation: away, reason: :victory, value: 3)
      end
    end

    context "when it is a draw" do
      let(:score) { [1, 1] }

      it "rewards both teams for the draw", :aggregate_failures do
        expect(awards[:home]).to include(nation: home, reason: :draw, value: 1)
        expect(awards[:away]).to include(nation: away, reason: :draw, value: 1)
      end
    end

    context "with any score" do
      let(:score) { [2, 0] }

      it "puts Boltun's phrasing into the description", :aggregate_failures do
        expect(awards[:home]).to include(description: "описание")
        expect(awards[:away]).to include(description: "описание")
      end
    end
  end
end
