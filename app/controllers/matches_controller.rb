class MatchesController < ApplicationController
  def index
    @matches = Match.includes(
      home: { squads: :user },
      away: { squads: :user }
    ).order(played_at: :desc)
  end
end
