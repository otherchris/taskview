require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest
  test "should create task" do
    assert_difference("Task.count") do
      post tasks_url, params: {task: {name: "Test Task", duration_in_seconds: 60}}
    end

    assert_redirected_to root_url
  end
end
