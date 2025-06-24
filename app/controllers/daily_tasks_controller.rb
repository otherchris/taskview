class DailyTasksController < ApplicationController
  def index
    @daily_tasks = DailyTask.all
  end

  def new
    @daily_task = DailyTask.new
  end

  def create
    @daily_task = DailyTask.new(daily_task_params)

    respond_to do |format|
      if @daily_task.save
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("daily_tasks_list", partial: "daily_tasks/daily_task", locals: {daily_task: @daily_task}),
            turbo_stream.replace("new_daily_task", "")
          ]
        end
        format.html { redirect_to daily_tasks_path, notice: "Daily Task created" }
      else
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_daily_task", partial: "daily_tasks/form", locals: {daily_task: @daily_task})
        end
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def complete
    @daily_task = DailyTask.find(params[:id])
    @daily_task.complete!

    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@daily_task) }
      format.html { redirect_to daily_tasks_path, notice: "Task completed!" }
    end
  end

  private

  def daily_task_params
    params.require(:daily_task).permit(:title, :description, :times_per_day)
  end
end
