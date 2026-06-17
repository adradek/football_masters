require "rails_helper"

RSpec.describe SquadInspector do
  let(:message) { "Франция, Бразилия, Япония" }

  subject(:inspector) { described_class.new(message:) }

  describe "#message" do
    it "returns the provided message" do
      expect(inspector.message).to eq(message)
    end
  end

  describe "#call" do
    subject(:service_call) { inspector.call }

    it "does not return an inspection result yet" do
      expect(service_call).to be_nil
    end
  end
end
