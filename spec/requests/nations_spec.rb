require 'rails_helper'

RSpec.describe "Nations", type: :request do
  describe "GET /nations/:id" do
    let(:nation) { create(:nation, name: "Бразилия", points: 7) }

    it "renders the public nation page" do
      get nation_path(nation)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Бразилия")
    end

    it "shows owners, matches and bonus breakdown" do
      rival = create(:nation)
      user = create(:user, name: "Пеле")
      squad = create(:squad, user: user, main: true)
      squad.nations << nation

      match = create(:match, home: nation, away: rival)
      create(:bonus, match: match, nation: nation, reason: :victory, value: 3)

      get nation_path(nation)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include("Пеле")          # владелец
      expect(response.body).to include("Победа")         # причина бонуса
      expect(response.body).to include(rival.name)       # соперник в матче
    end
  end
end
