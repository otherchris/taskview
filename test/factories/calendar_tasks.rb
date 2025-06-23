FactoryBot.define do
  factory :calendar_task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    due_date { Faker::Date.forward(days: 23) }
  end
end
