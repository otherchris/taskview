class CalendarTask < ApplicationRecord
  has_many :completions, as: :completable, dependent: :destroy

  enum :repeats, {no_repeats: "no_repeats", daily: "daily", weekly: "weekly", monthly: "monthly", annually: "annually"}, prefix: true

  validates :initial_date, presence: true

  def next_date
    return initial_date if repeats_no_repeats?

    now = Time.current

    return initial_date if initial_date > now

    next_occurrence = initial_date

    duration_method = case repeats.to_sym
    when :daily
      :days
    when :weekly
      :weeks
    when :monthly
      :months
    when :annually
      :years
    end

    while next_occurrence <= now
      next_occurrence = next_occurrence.advance(duration_method => repeats_every)
    end

    next_occurrence
  end

  def complete!
    completions.create!(assigned_date: next_date)
  end
end
