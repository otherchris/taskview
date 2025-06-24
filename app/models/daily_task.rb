class DailyTask < ApplicationRecord
  include Completable

  attribute :times_per_day, :integer, default: 1
  serialize :schedule, type: Array, coder: JSON

  validate :schedule_length_matches_times_per_day, if: -> { schedule.present? }
  before_create :generate_schedule, if: -> { schedule.blank? }

  def current_streak
    return 0 unless successful_on?(Date.yesterday)

    streak = 0
    current_date = Date.yesterday
    while successful_on?(current_date)
      streak += 1
      current_date -= 1.day
    end
    streak
  end

  def successful_on?(date)
    completions.where(created_at: date.all_day).count >= times_per_day
  end

  def next_date
    now = Time.current
    today = now.to_date

    sorted_schedule = schedule.map { |time_str| Time.zone.parse(time_str) }.sort

    sorted_schedule.each do |time|
      scheduled_time_today = time.change(year: today.year, month: today.month, day: today.day)
      return scheduled_time_today if scheduled_time_today > now
    end

    # If all times for today have passed, return the first time for tomorrow
    first_time_tomorrow = sorted_schedule.first
    first_time_tomorrow.change(year: today.year, month: today.month, day: today.day) + 1.day
  end

  def complete!
    completions.create!(assigned_date: next_date)
  end

  def completions_for_today
    completions.where(assigned_date: Date.current)
  end

  def completed_today?
    completions_for_today.count >= times_per_day
  end

  private

  def schedule_length_matches_times_per_day
    return if schedule.length == times_per_day

    errors.add(:schedule, "length must match times_per_day")
  end

  def generate_schedule
    return if times_per_day.zero?

    interval = 1440 / times_per_day
    self.schedule = Array.new(times_per_day - 1) do |i|
      minutes_from_midnight = (i + 1) * interval
      (Time.current.beginning_of_day + minutes_from_midnight.minutes).strftime("%H:%M")
    end
    schedule << "23:59"
  end

  def schedule_times_for_date(date)
    # Implementation of schedule_times_for_date method
  end
end
