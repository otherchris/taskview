require "application_system_test_case"

class HomePagesTest < ApplicationSystemTestCase
  test "visiting the index and creating a task" do
    visit root_url

    click_on "New Task"

    fill_in "Name", with: "Test Daily Task"
    check "Daily"

    click_on "Create Task"

    assert_text "Test Daily Task"
  end
end
