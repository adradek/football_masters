# frozen_string_literal: true

module Bonuses
  class SugarDaddy < ApplicationService
    include Dry::Monads[:result, :do]

    def initialize(match:)
      @match = match
    end

    def call
      yield check_participants
      yield check_match_status
      yield check_score_correctness
      # TODO: check score correctness for play-offs

      Success(match_bonuses)
    end

    private

    attr_reader :match, :score

    def check_participants
      return Failure(error: :absent_participants, error_message: "Не указана команда хозяев") if match.home.blank?
      return Failure(error: :absent_participants, error_message: "Не указана команда гостей") if match.away.blank?

      Success()
    end

    def check_match_status
      return Success() if match.finished?

      Failure(error: :must_be_finished, error_message: "Непреемлемый статус матча: #{match.state}")
    end

    def check_score_correctness
      score = match.score
      failure = Failure(error: :score_problems, error_message: "Некорректный счёт: #{score.inspect}")

      return failure unless score
      return failure unless (goals = score.split(":").map(&:strip)).size == 2
      return failure unless goals.all? { it.match?(/\A\d+\z/) }

      @score = goals.map(&:to_i)

      Success()
    end

    def match_bonuses
      Clerk.new(match:, score:).prepare_awards
    end
  end
end
