class TasksController < ApplicationController
  def create
    task_attributes = task_params.to_h

    interval_value = task_attributes.delete("interval_value").to_i
    interval_unit = task_attributes.delete("interval_unit")
    times_per_day = task_attributes.delete("times_per_day").to_i

    interval_in_seconds = 0

    if task_attributes["daily"] == "1"
      interval_in_seconds = (24 * 60 * 60) / times_per_day if times_per_day.positive?
    else
      interval_in_seconds = case interval_unit
      when "days"
        interval_value.days.in_seconds
      when "weeks"
        interval_value.weeks.in_seconds
      when "months"
        interval_value.months.in_seconds
      when "years"
        interval_value.years.in_seconds
      else
        0
      end
    end

    @task = Task.new(task_attributes.merge(interval_in_seconds: interval_in_seconds))

    if @task.save
      redirect_to root_path, notice: "Task was successfully created."
    else
      render "home/index", status: :unprocessable_entity
    end
  end

  def complete
    @task = Task.find(params[:id])
    @task.completions.create
    if @task.daily?
    else
      @task.update(created_at: Time.current)
    end
    redirect_to root_path
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path, notice: "Task was successfully destroyed."
  end

  private

  def task_params
    params.require(:task).permit(:name, :daily, :interval_value, :interval_unit, :times_per_day)
  end
end
