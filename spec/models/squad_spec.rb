require "rails_helper"

RSpec.describe Squad do
  # let(:user) { create :user }

  # let(:moby_dick) { create :book, :moby_dick }
  # let(:evil_13) { create :book, :evil_13 }
  # let(:vechera) { create :book, :vechera }

  # describe "compilations scope" do
  #   before do
  #     described_class.create!(user: user, book: moby_dick)
  #     described_class.create!(user: user, book: evil_13)
  #     described_class.create!(user: user, book: vechera)
  #   end

  #   let(:readings) { user.readings.compilations }

  #   it "returns all compilations" do
  #     expect(readings.map { _1.book.title }).to match_array([evil_13, vechera].map(&:title))
  #   end

  #   it "ignores other books" do
  #     expect(readings.map { _1.book.title }).not_to include(moby_dick.title)
  #   end
  # end

  describe "main field validation" do
    let(:user) { create :user }

    context "when the main squad exists" do
      let!(:main_squad) { create(:squad, user:, main: true) }
      let(:new_main_squad) { build(:squad, user:, main: true) }
      let(:new_secondary_squad) { build(:squad, user:, main: false) }

      it "claims that new main squad is not valid" do
        expect(new_main_squad).not_to be_valid
      end

      it "gives the correct error message" do
        new_main_squad.valid?
        expect(new_main_squad.errors[:main]).to include("has already been taken")
      end

      it "allows to create a secondary squad" do
        expect { new_secondary_squad.save! }.to change(Squad, :count).by(1)
      end
    end
  end
end
