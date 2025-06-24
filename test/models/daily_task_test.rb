require "test_helper"

class DailyTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can be saved" do
    daily_task = build(:daily_task)
    assert daily_task.save, "Could not save the daily task"
  end

  test "defaults times_per_day to 1" do
    daily_task = DailyTask.new
    assert_equal 1, daily_task.times_per_day
  end

  test "is valid without a schedule" do
    daily_task = build(:daily_task)
    assert daily_task.valid?
  end

  test "is valid when schedule length matches times_per_day" do
    daily_task = build(:daily_task, :with_schedule)
    assert daily_task.valid?
  end

  test "is invalid when schedule length does not match times_per_day" do
    daily_task = build(:daily_task, times_per_day: 3)
    daily_task.schedule = ["09:00", "14:00"]
    assert_not daily_task.valid?
    assert_includes daily_task.errors[:schedule], "length must match times_per_day"
  end

  test "generates a schedule if none is provided on create" do
    daily_task = create(:daily_task, times_per_day: 4, schedule: nil)
    assert_not_nil daily_task.schedule
    assert_equal ["06:00", "12:00", "18:00", "23:59"], daily_task.schedule
  end

  test "current_streak is 0 when there are no completions" do
    daily_task = create(:daily_task)
    assert_equal 0, daily_task.current_streak
  end

  test "current_streak is 0 if yesterday was not successful" do
    daily_task = create(:daily_task, times_per_day: 1)
    create(:completion, completable: daily_task, assigned_date: 2.days.ago)
    assert_equal 0, daily_task.current_streak
  end

  test "current_streak is 1 if yesterday was successful but not the day before" do
    daily_task = create(:daily_task, times_per_day: 1)
    create(:completion, completable: daily_task, assigned_date: 1.day.ago)
    assert_equal 1, daily_task.current_streak
  end

  test "current_streak is 3 for a 3-day streak ending yesterday" do
    daily_task = create(:daily_task, times_per_day: 1)
    create(:completion, completable: daily_task, assigned_date: 1.day.ago)
    create(:completion, completable: daily_task, assigned_date: 2.days.ago)
    create(:completion, completable: daily_task, assigned_date: 3.days.ago)
    assert_equal 3, daily_task.current_streak
  end

  test "current_streak ignores completions from today" do
    daily_task = create(:daily_task)
    create(:completion, completable: daily_task, assigned_date: Time.current)
    assert_equal 0, daily_task.current_streak
  end

  test "current_streak works for times_per_day greater than 1" do
    daily_task = create(:daily_task, times_per_day: 2)
    create_list(:completion, 2, completable: daily_task, assigned_date: 1.day.ago)
    create_list(:completion, 2, completable: daily_task, assigned_date: 2.days.ago)
    create(:completion, completable: daily_task, assigned_date: 3.days.ago)
    assert_equal 2, daily_task.current_streak
  end

  test "current_streak is 0 if times_per_day is not met" do
    daily_task = create(:daily_task, times_per_day: 2)
    create(:completion, completable: daily_task, assigned_date: 1.day.ago)
    assert_equal 0, daily_task.current_streak
  end

  test "next_date returns the next scheduled time today" do
    travel_to Time.zone.local(2025, 6, 24, 12, 0, 0) do
      task = create(:daily_task, schedule: ["09:00", "14:00", "19:00"], times_per_day: 3)
      assert_equal Time.zone.local(2025, 6, 24, 14, 0, 0), task.next_date
    end
  end

  test "next_date returns the first scheduled time tomorrow if all of today's have passed" do
    travel_to Time.zone.local(2025, 6, 24, 20, 0, 0) do
      task = create(:daily_task, schedule: ["09:00", "14:00", "19:00"], times_per_day: 3)
      assert_equal Time.zone.local(2025, 6, 25, 9, 0, 0), task.next_date
    end
  end

  test "#complete! creates a completion with the next_date" do
    travel_to Time.zone.local(2025, 6, 24, 12, 0, 0) do
      task = create(:daily_task, schedule: ["09:00", "14:00", "19:00"], times_per_day: 3)
      next_date = task.next_date
      completion = task.complete!

      assert completion.persisted?
      assert_equal next_date.to_date, completion.assigned_date
      assert_equal task, completion.completable
    end
  end
end
