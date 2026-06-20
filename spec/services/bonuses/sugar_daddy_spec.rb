require "rails_helper"

RSpec.describe Bonuses::SugarDaddy do
  shared_examples "failure" do
    it "returns Failure" do
      expect(service_call).to be_failure
    end
  end

  shared_examples "failure no participants" do
    include_examples "failure"

    it "returns error details", :aggregate_failures do
      expect(service_call.failure[:error]).to eq(:absent_participants)
      expect(service_call.failure[:error_message]).to eq(error_message)
    end
  end

  shared_examples "wrong status failure" do
    include_examples "failure"

    it "returns error details", :aggregate_failures do
      expect(service_call.failure[:error]).to eq(:must_be_finished)
      expect(service_call.failure[:error_message]).to eq("Непреемлемый статус матча: #{state}")
    end
  end

  shared_examples "score problems failure" do
    include_examples "failure"

    it "returns error details", :aggregate_failures do
      expect(service_call.failure[:error]).to eq(:score_problems)
      expect(service_call.failure[:error_message]).to eq(error_message)
    end
  end

  describe "#call" do
    subject(:service_call) { described_class.call(match:) }

    before do
      stub_const("Bonuses::Boltun", double("Boltun"))
      allow(Bonuses::Boltun).to receive(:call).and_return("описание")
    end

    let(:home) { create(:nation, name: "Франция") }
    let(:away) { create(:nation, name: "Россия") }
    let(:score) { "2:3" }
    let(:match) { create(:match, home:, away:, score:) }

    context "when participants are absent" do
      context "without home team" do
        let(:home) { nil }
        let(:error_message) { "Не указана команда хозяев" }

        it_behaves_like "failure no participants"
      end

      context "without away team" do
        let(:away) { nil }
        let(:error_message) { "Не указана команда гостей" }

        it_behaves_like "failure no participants"
      end
    end

    context "when match is not finished" do
      let(:match) { create(:match, home:, away:, score: "2:3", state:) }

      context "when match not started" do
        let(:state) { :not_started }
        it_behaves_like "wrong status failure"
      end

      context "when match is live" do
        let(:state) { :live }
        it_behaves_like "wrong status failure"
      end

      context "when match is completed" do
        let(:state) { :completed }
        it_behaves_like "wrong status failure"
      end
    end

    context "when score is not okay" do
      [nil, "", "1:2:3", "1:2x"].each do |wrong_score|
        context "when score is #{wrong_score.inspect}" do
          let(:score) { wrong_score }
          let(:error_message) { "Некорректный счёт: #{score.inspect}" }

          it_behaves_like "score problems failure"
        end
      end
    end

    context "everything is okay" do
      it "succeeds" do
        expect(service_call).to be_success
      end

      it "contains bonuses for both teams", :aggregate_failures do
        expect(service_call.value!).to include(
          home: a_hash_including(reason: :defeat, value: 0),
          away: a_hash_including(reason: :victory, value: 3)
        )
      end
    end
  end
end
