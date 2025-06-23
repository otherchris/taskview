FactoryBot.define do
  factory :daily_task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
  end
end
