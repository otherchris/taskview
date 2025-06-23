require "test_helper"

class CompletionTest < ActiveSupport::TestCase
  test "can be added to a DailyTask" do
    daily_task = create(:daily_task)
    completion = daily_task.completions.create
    assert completion.persisted?
    assert_equal daily_task, completion.completable
  end

  test "can be added to an IntervalTask" do
    interval_task = create(:interval_task)
    completion = interval_task.completions.create
    assert completion.persisted?
    assert_equal interval_task, completion.completable
  end

  test "can be added to a CalendarTask" do
    calendar_task = create(:calendar_task)
    completion = calendar_task.completions.create
    assert completion.persisted?
    assert_equal calendar_task, completion.completable
  end
end
