require "test_helper"

class CalendarTaskTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "can be saved" do
    calendar_task = CalendarTask.new(title: "Test Task", description: "Test Description", due_date: Date.today)
    assert calendar_task.save, "Could not save the calendar task"
  end
end
