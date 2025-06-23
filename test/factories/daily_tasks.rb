FactoryBot.define do
  factory :daily_task do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    times_per_day { Faker::Number.between(from: 1, to: 5) }

    trait :with_schedule do
      after(:build) do |task|
        task.schedule = Array.new(task.times_per_day) { Faker::Time.forward(days: 0, period: :all).strftime("%H:%M") }
      end
    end
  end
end
