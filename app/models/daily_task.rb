class DailyTask < ApplicationRecord
  has_many :completions, as: :completable, dependent: :destroy

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
end
