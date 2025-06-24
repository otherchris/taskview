FactoryBot.define do
  factory :interval_task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    interval { Faker::Number.between(from: 1, to: 30) }
    repeats { "no_repeats" }
    repeats_every { 1 }
  end
end
