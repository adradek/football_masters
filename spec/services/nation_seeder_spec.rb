require "rails_helper"

RSpec.describe NationSeeder do
  describe "#call" do
    let(:nations_data) { described_class::NATIONS }

    context "without groups" do
      subject(:service_call) { described_class.new.call(with_groups: false) }

      it "creates all nations" do
        expect { service_call }.to change(Nation, :count).by(nations_data.size)
      end

      it "does not create any groups" do
        expect { service_call }.not_to change(Group, :count)
      end
    end

    context "with groups" do
      subject(:service_call) { described_class.new.call(with_groups: true) }

      it "creates all nations" do
        expect { service_call }.to change(Nation, :count).by(nations_data.size)
      end

      it "creates all groups" do
        groups = nations_data.map { |nation_data| nation_data[:group] }.uniq
        expect { service_call }.to change(Group, :count).by(groups.size)
      end

      it "binds nations to groups" do
        group_sizes = Group.all.map { |gr| gr.nations.size }
        expect(group_sizes).to all(eq(4))
      end
    end
  end
end
