class CalendarTask < ApplicationRecord
  include Completable
  include Repeatable

  validates :initial_date, presence: true

  def next_date
    return initial_date if repeats_no_repeats? || initial_date > Time.current

    next_occurrence = initial_date
    while next_occurrence <= Time.current
      next_occurrence = advance_date(next_occurrence)
    end
    next_occurrence
  end

  def complete!
    completions.create!(assigned_date: next_date)
  end
end
