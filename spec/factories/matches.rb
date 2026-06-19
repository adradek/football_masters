FactoryBot.define do
  factory :match do
    stage { 1 }
    played_at { "2026-06-19 11:11:22" }
    home { nil }
    away { nil }
    score { "MyString" }
    score_extra { "MyString" }
    score_penalty { "MyString" }
    state { 1 }
  end
end
