FactoryBot.define do
  factory :match do
    stage { :round_of_32 }
    state { :finished }
    played_at { "2026-06-19 11:11:22" }
    association :home, factory: :nation
    association :away, factory: :nation
    score { "1:0" }
    score_extra { nil }
    score_penalty { nil }
  end
end
