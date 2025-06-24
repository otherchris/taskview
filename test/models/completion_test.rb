require "test_helper"

class CompletionTest < ActiveSupport::TestCase
  test "can be added to a DailyTask" do
    daily_task = create(:daily_task)
    completion = create(:completion, completable: daily_task)
    assert completion.persisted?
    assert_equal daily_task, completion.completable
  end

  test "can be added to an IntervalTask" do
    interval_task = create(:interval_task)
    completion = create(:completion, completable: interval_task)
    assert completion.persisted?
    assert_equal interval_task, completion.completable
  end

  test "can be added to a CalendarTask" do
    calendar_task = create(:calendar_task)
    completion = create(:completion, completable: calendar_task)
    assert completion.persisted?
    assert_equal calendar_task, completion.completable
  end

  test "can have an assigned_date" do
    completion = create(:completion, assigned_date: Date.yesterday)
    assert_equal Date.yesterday, completion.assigned_date
  end
end
