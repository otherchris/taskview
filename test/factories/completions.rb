FactoryBot.define do
  factory :completion do
    association :completable, factory: :daily_task
    assigned_date { Date.current }
  end
end
