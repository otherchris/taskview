FactoryBot.define do
  factory :calendar_task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    due_date { Faker::Date.forward(days: 23) }
    repeats { "no_repeats" }
    repeats_every { 1 }
    initial_date { Faker::Time.between(from: 1.year.ago, to: Time.now) }
  end
end
