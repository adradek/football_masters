FactoryBot.define do
  factory :bonus do
    match { nil }
    nation { nil }
    value { 1 }
    description { "MyString" }
  end
end
