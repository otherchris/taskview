class IntervalTask < ApplicationRecord
  include Completable
  include Repeatable

  before_validation :set_last_date, on: :create
  validates :last_date, presence: true

  def next_date
    advance_date(last_date)
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
