require "application_system_test_case"

class DailyTasksTest < ApplicationSystemTestCase
  test "visiting the daily tasks index shows all daily tasks" do
    create(:daily_task, title: "My Daily Task")
    visit daily_tasks_url
    assert_text "My Daily Task"
  end

  test "creating a new daily task" do
    visit daily_tasks_url

    click_on "Create"

    within "#new_daily_task" do
      fill_in "Title", with: "New System Test Daily Task"
      fill_in "Description", with: "A great description"
      fill_in "Times per day", with: 2
      click_on "Save"
    end

    assert_no_selector "#new_daily_task form"
    assert_text "New System Test Daily Task"
  end

  test "completing a daily task" do
    daily_task = create(:daily_task, title: "My new task", times_per_day: 2, schedule: ["09:00", "17:00"])

    travel_to Time.zone.local(2025, 6, 24, 8, 0, 0) do
      visit daily_tasks_url

      within "#daily_task_#{daily_task.id}" do
        assert_text "My new task (0/2)"
        click_button "Complete"
      end

      within "#daily_task_#{daily_task.id}" do
        assert_text "My new task (1/2)"
        click_button "Complete"
      end

      within "#daily_task_#{daily_task.id}" do
        assert_text "My new task (2/2)"
        assert_text "Done!"
        assert_no_button "Complete"
      end
    end
  end
end
