module MatchProcessings
  class Create < ApplicationCommand
    attr_reader :match

    def initialize(match:)
      @match = match
    end

    def call
      Bonuses::Cashier.call(match:)
    end
  end
end
