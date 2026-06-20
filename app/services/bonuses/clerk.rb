# frozen_string_literal: true

module Bonuses
  class Clerk
    POINTS = { defeat: 0, draw: 1, victory: 3 }.freeze

    def initialize(match:, score:)
      @match = match
      @home_goals, @away_goals = score
    end

    def prepare_awards
      {
        home: award(match.home, opponent: match.away, goals_for: home_goals, goals_against: away_goals),
        away: award(match.away, opponent: match.home, goals_for: away_goals, goals_against: home_goals)
      }
    end

    private

    attr_reader :match, :home_goals, :away_goals

    def award(nation, opponent:, goals_for:, goals_against:)
      reason = reason_for(goals_for, goals_against)

      {
        match:,
        nation:,
        reason:,
        value: POINTS.fetch(reason),
        description: Boltun.call(reason:, stage: match.stage, opponent:, score: "#{goals_for}:#{goals_against}")
      }
    end

    def reason_for(goals_for, goals_against)
      return :draw if goals_for == goals_against

      goals_for > goals_against ? :victory : :defeat
    end
  end
end
