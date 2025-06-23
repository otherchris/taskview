FactoryBot.define do
  factory :completion do
    association :completable, factory: :daily_task
  end
end
