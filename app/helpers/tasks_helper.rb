module TasksHelper
  def task_color(task)
    return "green" if task.interval_in_seconds.nil?

    time_elapsed = Time.current - task.created_at
    if time_elapsed < task.interval_in_seconds
      "green"
    else
      "red"
    end
  end

  def time_remaining_in_words(task)
    return "Never expires" if task.interval_in_seconds.nil?

    expires_at = task.created_at + task.interval_in_seconds
    if Time.current < expires_at
      "#{distance_of_time_in_words(Time.current, expires_at)} remaining"
    else
      "Expired"
    end
  end
end
