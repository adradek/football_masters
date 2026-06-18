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

    context "with total price greater than 65" do
      let(:message) { "Испания\nБразилия\nФранция\nАнглия\nГермания\nПортугалия\nАргентина\nНидерланды" }

      it "returns Failure" do
        expect(service_call).to be_failure
      end

      it "stores error and error_message", :aggregate_failures do
        expect(service_call.failure[:error]).to eq(:incorrect_list)
        expect(service_call.failure[:error_message]).to eq("Суммарная стоимость команд (147) превышает 65")
      end
    end

    context "with current MAIN squad already exists" do
      let(:user) { create :user }
      let(:existed_squad) { create(:squad, user:, main: true) }
      let(:names) do
        %w[США Англия Бельгия Австралия Канада Колумбия Катар Гаити]
      end
      let(:message) { names.join("\n") }

      before { Nation.where(name: names).each { |nation| existed_squad.nations << nation } }

      it "returns Failure" do
        expect(service_call).to be_failure
      end

      it "stores error and error_message", :aggregate_failures do
        expect(service_call.failure[:error]).to eq(:incorrect_list)
        expect(service_call.failure[:error_message]).to eq("Такой набор уже выбрал #{user.name}")
      end
    end
  end
end
