require "test_helper"

class IntervalTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can be saved" do
    interval_task = IntervalTask.new(title: "Test Task", description: "Test Description", interval: 1)
    assert interval_task.save, "Could not save the interval task"
  end
end
