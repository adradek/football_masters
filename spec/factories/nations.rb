FactoryBot.define do
  factory :nation do
    sequence(:name) { |n| "Nation #{n}" }
    sequence(:fifa_place) { |n| n }
    sequence(:fifa_rank) { |n| 1000 - n }
    flag_emoji { "🏳️" }
    price { 10 }
  end
end
