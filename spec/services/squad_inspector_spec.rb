require "rails_helper"

RSpec.describe SquadInspector do
  subject(:service_call) { described_class.call(message:) }

  let(:message) { "Франция, Бразилия, Япония" }

  before { NationSeeder.new(with_groups: false).call }

  describe ".call" do
    context "with insufficient number of names" do
      let(:message) { "Нидерланды\nЭквадор\nИран" }

      it "returns Failure" do
        expect(service_call).to be_failure
      end

      it "stores error and error_message", :aggregate_failures do
        expect(service_call.failure[:error]).to eq(:incorrect_list)
        expect(service_call.failure[:error_message]).to include(/содержит некорректное колчество команд \(3\)/)
      end
    end

    context "with a mistake in the names" do
      let(:message) { "Голландия\nЭквадор\nИран\nСША\nБразилия\nГана\nФранция\nБельгия\n" }

      it "returns Failure" do
        expect(service_call).to be_failure
      end

      it "stores error and error_message", :aggregate_failures do
        expect(service_call.failure[:error]).to eq(:incorrect_list)
        expect(service_call.failure[:error_message]).to include(/содержит некорректные команды: Голландия/)
      end
    end

    context "with duplicates" do
      let(:message) { "Сша\nЭквадор\nИран\nСША\nБразилия\nГана\nФранция\nБельгия\n" }

      it "returns Failure" do
        expect(service_call).to be_failure
      end

      it "stores error and error_message", :aggregate_failures do
        expect(service_call.failure[:error]).to eq(:incorrect_list)
        expect(service_call.failure[:error_message])
          .to eq("В базе нашлось 7 команд: Бразилия, США, Эквадор, Бельгия, Иран, Франция, Гана")
      end
    end
  end
end
