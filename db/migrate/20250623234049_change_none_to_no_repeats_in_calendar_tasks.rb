class ChangeNoneToNoRepeatsInCalendarTasks < ActiveRecord::Migration[8.0]
  def up
    CalendarTask.where(repeats: "none").update_all(repeats: "no_repeats")
    change_column_default :calendar_tasks, :repeats, from: "none", to: "no_repeats"
  end

  def down
    CalendarTask.where(repeats: "no_repeats").update_all(repeats: "none")
    change_column_default :calendar_tasks, :repeats, from: "no_repeats", to: "none"
  end
end
