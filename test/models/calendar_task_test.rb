require "test_helper"

class CalendarTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can be saved" do
    calendar_task = build(:calendar_task)
    assert calendar_task.save, "Could not save the calendar task"
  end

  test "defaults to not repeating" do
    calendar_task = CalendarTask.new
    assert_equal "no_repeats", calendar_task.repeats
  end

  test "repeats_every defaults to 1" do
    calendar_task = CalendarTask.new
    assert_equal 1, calendar_task.repeats_every
  end

  test "is invalid without an initial_date" do
    calendar_task = build(:calendar_task, initial_date: nil)
    assert_not calendar_task.valid?
  end

  test "next_date returns initial_date if not repeating" do
    task = build(:calendar_task, repeats: "no_repeats", initial_date: 2.days.ago)
    assert_equal task.initial_date, task.next_date
  end

  test "next_date returns initial_date if it is in the future" do
    future_date = 2.days.from_now
    task = build(:calendar_task, repeats: "daily", initial_date: future_date)
    assert_equal future_date.to_s, task.next_date.to_s
  end

  test "next_date calculation is correct for all repetition types" do
    travel_to Time.zone.local(2025, 6, 24, 12, 0, 0) do
      # Daily
      initial_date = Time.zone.local(2025, 6, 20, 10, 0, 0)
      task = build(:calendar_task, repeats: "daily", repeats_every: 1, initial_date: initial_date)
      assert_equal Time.zone.local(2025, 6, 25, 10, 0, 0), task.next_date

      # Every 3 days
      task = build(:calendar_task, repeats: "daily", repeats_every: 3, initial_date: initial_date)
      assert_equal Time.zone.local(2025, 6, 26, 10, 0, 0), task.next_date

      # Weekly
      initial_date_weekly = Time.zone.local(2025, 6, 10, 10, 0, 0) # A Tuesday
      task_weekly = build(:calendar_task, repeats: "weekly", repeats_every: 1, initial_date: initial_date_weekly)
      assert_equal Time.zone.local(2025, 7, 1, 10, 0, 0), task_weekly.next_date

      # Every 2 weeks
      task_2_weeks = build(:calendar_task, repeats: "weekly", repeats_every: 2, initial_date: initial_date_weekly)
      assert_equal Time.zone.local(2025, 7, 8, 10, 0, 0), task_2_weeks.next_date

      # Monthly
      initial_date_monthly = Time.zone.local(2025, 4, 24, 10, 0, 0)
      task_monthly = build(:calendar_task, repeats: "monthly", repeats_every: 1, initial_date: initial_date_monthly)
      assert_equal Time.zone.local(2025, 7, 24, 10, 0, 0), task_monthly.next_date

      # Every 2 months
      task_2_months = build(:calendar_task, repeats: "monthly", repeats_every: 2, initial_date: initial_date_monthly)
      assert_equal Time.zone.local(2025, 8, 24, 10, 0, 0), task_2_months.next_date

      # Annually
      initial_date_annually = Time.zone.local(2023, 6, 24, 10, 0, 0)
      task_annually = build(:calendar_task, repeats: "annually", repeats_every: 1, initial_date: initial_date_annually)
      assert_equal Time.zone.local(2026, 6, 24, 10, 0, 0), task_annually.next_date

      # Every 2 years
      task_2_years = build(:calendar_task, repeats: "annually", repeats_every: 2, initial_date: initial_date_annually)
      assert_equal Time.zone.local(2027, 6, 24, 10, 0, 0), task_2_years.next_date
    end
  end

  test "#complete! creates a completion with the next_date" do
    task = create(:calendar_task, repeats: "daily", initial_date: 2.days.ago)
    next_date = task.next_date
    completion = task.complete!

    assert completion.persisted?
    assert_equal next_date.to_date, completion.assigned_date.to_date
    assert_equal task, completion.completable
  end

  test "can be set to repeat daily" do
    calendar_task = build(:calendar_task, repeats: "daily")
    assert calendar_task.valid?
    assert calendar_task.repeats_daily?
  end

  test "cannot be set to an invalid repeat value" do
    assert_raises(ArgumentError) do
      build(:calendar_task, repeats: "invalid_value")
    end
  end
end
