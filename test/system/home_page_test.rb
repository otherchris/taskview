require "application_system_test_case"

class HomePageTest < ApplicationSystemTestCase
  test "visiting the home page" do
    visit root_url

    assert_selector "h1", text: "Welcome to TaskView"
    assert_link "Daily Tasks", href: daily_tasks_path
    assert_link "Calendar Tasks", href: calendar_tasks_path
    assert_link "Interval Tasks", href: interval_tasks_path
  end
end
