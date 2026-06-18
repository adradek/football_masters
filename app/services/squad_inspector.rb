# frozen_string_literal: true

class SquadInspector
  include Dry::Monads[:result, :do]

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
    # yield check_uniqueness

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
            error_message: "Список содержит некорректные команды: #{mistaken_nations.join(', ')}")
    end

    Failure(error: :incorrect_list,
            error_message: "В базе нашлось #{nations.size} команд: #{nations.map(&:name).join(", ")}")
  end

  def check_score
  end
end
