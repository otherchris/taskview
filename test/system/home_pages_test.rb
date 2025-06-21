require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
  test "visiting the index and creating a task" do
    visit root_url

    fill_in "Name", with: "Test Task"
    fill_in "Minutes", with: "10"

    click_on "Create Task"

    assert_text "Test Task"
    assert_text "10 minutes remaining"
  end
end
