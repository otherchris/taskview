class IntervalTask < ApplicationRecord
  has_many :completions, as: :completable, dependent: :destroy

  enum :repeats, {no_repeats: "no_repeats", daily: "daily", weekly: "weekly", monthly: "monthly", annually: "annually"}, prefix: true

  before_validation :set_last_date, on: :create
  validates :last_date, presence: true

  def next_date
    return nil if repeats_no_repeats?

    case repeats.to_sym
    when :daily
      last_date + repeats_every.days
    when :weekly
      last_date + repeats_every.weeks
    when :monthly
      last_date + repeats_every.months
    when :annually
      last_date + repeats_every.years
    end
  end

  def complete!
    transaction do
      completions.create!(assigned_date: Time.zone.today)
      update!(last_date: Time.current)
    end
  end

  private

  def set_last_date
    self.last_date ||= Time.current
  end
end
