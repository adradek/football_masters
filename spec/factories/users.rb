FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    secret { Faker::Internet.password(min_length: 16) }
    role { :member }
  end
end
