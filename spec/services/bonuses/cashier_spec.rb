require "rails_helper"

RSpec.describe Bonuses::Cashier do
  describe "#call" do
    subject(:service_call) { described_class.call(match:) }

    before do
      stub_const("Bonuses::Boltun", double("Boltun"))
      allow(Bonuses::Boltun).to receive(:call).and_return("описание")
    end

    let(:home) { create(:nation, name: "Франция") }
    let(:away) { create(:nation, name: "Россия") }
    let(:score) { "2:3" }
    let(:state) { :finished }
    let(:match) { create(:match, home:, away:, score:, state:) }

    context "when the match is valid" do
      it "succeeds" do
        expect(service_call).to be_success
      end

      it "creates a bonus for each team", :aggregate_failures do
        expect { service_call }.to change(Bonus, :count).by(2)

        expect(home.bonuses.pick(:reason, :value)).to eq(["defeat", 0])
        expect(away.bonuses.pick(:reason, :value)).to eq(["victory", 3])
      end

      it "marks the match as completed" do
        expect { service_call }.to change { match.reload.state }.from("finished").to("completed")
      end

      it "recalculates each nation's points as the sum of its bonuses", :aggregate_failures do
        create(:bonus, match: create(:match, home:, away: create(:nation)), nation: away, value: 7)

        service_call

        expect(home.reload.points).to eq(0)
        expect(away.reload.points).to eq(3 + 7)
      end
    end

    context "when the match does not pass validation" do
      let(:state) { :completed }

      it "returns the validation failure" do
        expect(service_call).to be_failure
        expect(service_call.failure[:error_message]).to eq("Непреемлемый статус матча: completed")
      end

      it "creates no bonuses and does not touch the match" do
        expect { service_call }.not_to change(Bonus, :count)
        expect(match.reload.state).to eq("completed")
      end
    end

    context "when persistence fails midway" do
      before { create(:bonus, match:, nation: away, value: 5) }

      it "rolls back everything", :aggregate_failures do
        expect { service_call }.to raise_error(ActiveRecord::RecordInvalid)

        expect(Bonus.where(match:, nation: home)).to be_empty
        expect(match.reload.state).to eq("finished")
      end
    end
  end
end
