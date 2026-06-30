class BracketsController < ApplicationController
  def index
    matches = Match.includes(:home, :away)
                   .where(stage: Playoff::KNOCKOUT_ROUNDS.keys + [ "third_place" ])
                   .order(:priority, :created_at)
                   .to_a

    @rounds = Playoff::KNOCKOUT_ROUNDS.map do |stage, size|
      played = matches.select { |match| match.stage == stage }
      [stage, Array.new(size) { |slot| played[slot] }]
    end

    @final = @rounds.find { |stage, _| stage == "final" }.last.first
    @bracket_rounds = @rounds.reject { |stage, _| stage == "final" }
    @third_place = matches.find { |match| match.stage == "third_place" }
  end
end
