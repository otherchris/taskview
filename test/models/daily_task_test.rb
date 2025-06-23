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
end
