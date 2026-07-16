require 'rails_helper'

RSpec.describe SquadsHelper, type: :helper do
  describe "#percentil_tier" do
    it "returns warning for top 1%" do
      expect(helper.percentil_tier(0.02)).to eq("warning")
      expect(helper.percentil_tier(1)).to eq("warning")
    end

    it "returns success for top 10%" do
      expect(helper.percentil_tier(5.5)).to eq("success")
    end

    it "returns info for top 50%" do
      expect(helper.percentil_tier(42)).to eq("info")
    end

    it "returns secondary for the rest" do
      expect(helper.percentil_tier(90)).to eq("secondary")
    end
  end

  describe "#format_percentil" do
    it "shows a floor below 0.01" do
      expect(helper.format_percentil(0.004)).to eq("< 0.01")
    end

    it "keeps two decimals below 0.1" do
      expect(helper.format_percentil(0.0234)).to eq("0.02")
    end

    it "keeps one decimal below 10" do
      expect(helper.format_percentil(1.337)).to eq("1.3")
    end

    it "rounds to integer above 10" do
      expect(helper.format_percentil(45.7)).to eq("46")
    end
  end

  describe "#percentil_title" do
    it "mirrors the precision of the percentil" do
      expect(helper.percentil_title(0.02)).to include("Лучше, чем 99.98%")
      expect(helper.percentil_title(90)).to include("Лучше, чем 10%")
    end

    it "does not overstate extreme results" do
      expect(helper.percentil_title(0.004)).to include("> 99.99%")
    end

    it "mentions the total squads count" do
      expect(helper.percentil_title(50)).to include("сквадов сопоставимой стоимости")
    end
  end
end
