# frozen_string_literal: true

module Bonuses
  class Cashier < ApplicationService
    include Dry::Monads[:result, :do]

    def initialize(match:)
      @match = match
    end

    def call
      awards = yield SugarDaddy.call(match:)

      ActiveRecord::Base.transaction do
        persist_bonuses(awards)
        match.completed!
        recalculate_points(awards)
      end

      Success(match)
    end

    private

    attr_reader :match

    def persist_bonuses(awards)
      awards.each_value { |attributes| Bonus.create!(attributes) }
    end

    def recalculate_points(awards)
      awards.each_value do |attributes|
        nation = attributes[:nation]
        nation.update!(points: nation.bonuses.sum(:value))
      end
    end
  end
end
