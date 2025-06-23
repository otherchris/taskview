require "test_helper"

class DailyTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can be saved" do
    daily_task = DailyTask.new(title: "Test Task", description: "Test Description")
    assert daily_task.save, "Could not save the daily task"
  end
end
