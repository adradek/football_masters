# frozen_string_literal: true

class SquadInspector
  include Dry::Monads[:result, :do]

  MAX_TOTAL_PRICE = 65
  REQUIRED_SQUAD_SIZE = 8

  attr_reader :message

  def self.call(message:)
    new(message:).call
  end

  def initialize(message:)
    @message = message
  end

  def call
    yield check_nation_correctness
    yield check_total_price
    yield check_main_squad_uniqueness

    Success(nations)
  end

  private

  attr_reader :names, :nations

  def check_nation_correctness
    yield parse_nations
    yield take_nations

    Success()
  end

  def parse_nations
    @names = message.split(/[,\s]+/).compact
    return Success() if names.size == REQUIRED_SQUAD_SIZE

    Failure(error: :incorrect_list,
            error_message: "Список содержит некорректное колчество команд (#{names.size})")
  end

  def take_nations
    @nations = Nation.where(normalized_name: names.map(&:downcase)).to_a
    return Success() if nations.size == REQUIRED_SQUAD_SIZE

    if (mistaken_nations = names.select { |name| nations.map(&:normalized_name).exclude?(name.downcase) }).present?
      return Failure(error: :incorrect_list,
        error_message: "Список содержит некорректные команды (#{mistaken_nations.size}): #{mistaken_nations.join(', ')}")
    end

    Failure(error: :incorrect_list,
      error_message: "В базе нашлось #{nations.size} команд: #{nations.map(&:name).join(", ")}")
  end

  def check_total_price
    total_price = nations.sum(&:price)
    return Success() if total_price <= MAX_TOTAL_PRICE

    Failure(error: :incorrect_list,
            error_message: "Суммарная стоимость команд (#{total_price}) превышает #{MAX_TOTAL_PRICE}")
  end

  def check_main_squad_uniqueness
    participant_ids = nations.map(&:id).sort

    Squad.main.includes(:nations).each do |squad|
      next unless squad.participant_ids == participant_ids

      return Failure(error: :incorrect_list, error_message: "Такой набор уже выбрал #{squad.user.name}")
    end

    Success()
  end
end
