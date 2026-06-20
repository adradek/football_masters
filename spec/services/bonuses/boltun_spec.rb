require "rails_helper"

RSpec.describe Bonuses::Boltun do
  subject(:phrase) { described_class.call(opponent:, reason:, stage:, score:) }

  let(:opponent) { instance_double(Nation, name: opponent_name) }
  let(:opponent_name) { "Франция" }
  let(:stage) { "group_round" }
  let(:score) { "3:1" }

  describe ".call" do
    context "when the team won" do
      let(:reason) { :victory }

      it "uses the instrumental case of the opponent" do
        expect(phrase).to eq("Победа над Францией в группе (3:1)")
      end
    end

    context "when the team drew" do
      let(:reason) { :draw }
      let(:score) { "1:1" }

      it "uses the instrumental case of the opponent" do
        expect(phrase).to eq("Ничья с Францией в группе (1:1)")
      end
    end

    context "when the team lost" do
      let(:reason) { :defeat }
      let(:score) { "0:2" }

      it "uses the genitive case of the opponent" do
        expect(phrase).to eq("Поражение от Франции в группе (0:2)")
      end
    end

    context "with a multi-word opponent" do
      let(:opponent_name) { "Босния и Герцеговина" }
      let(:reason) { :victory }

      it "uses the declined short form" do
        expect(phrase).to eq("Победа над Боснией в группе (3:1)")
      end
    end

    context "with an opponent missing from the declension tables" do
      let(:opponent_name) { "Россия" }
      let(:reason) { :victory }

      it "falls back to the nominative name as given" do
        expect(phrase).to eq("Победа над Россия в группе (3:1)")
      end
    end

    context "with the stage given as the model's enum value (a String)" do
      let(:reason) { :victory }

      {
        "group_round" => "в группе",
        "round_of_32" => "в 1/16",
        "eight_final" => "в 1/8",
        "quarter_final" => "в 1/4",
        "semi_final" => "в полуфинале",
        "third_place" => "за 3 место",
        "final" => "в финале"
      }.each do |stage_value, label|
        context "when stage is #{stage_value.inspect}" do
          let(:stage) { stage_value }

          it "renders the stage as #{label.inspect}" do
            expect(phrase).to include(label)
          end
        end
      end
    end

    context "with an unknown stage" do
      let(:reason) { :victory }
      let(:stage) { "play_in" }

      it "raises KeyError" do
        expect { phrase }.to raise_error(KeyError)
      end
    end
  end
end
