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

  def percent_to_expiration(task)
    return 100 if task.interval_in_seconds.nil? || task.interval_in_seconds.zero?

    time_elapsed = Time.current - task.created_at
    return 0 if time_elapsed >= task.interval_in_seconds

    percent_remaining = ((task.interval_in_seconds - time_elapsed) / task.interval_in_seconds) * 100
    percent_remaining.round(2)
  end

  def times_per_day(task)
    return 0 unless task.daily? && task.interval_in_seconds&.positive?
    (24 * 60 * 60) / task.interval_in_seconds
  end

  def completions_today(task)
    task.completions.count { |completion| completion.to_date == Date.today }
  end
end
