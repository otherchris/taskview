class TasksController < ApplicationController
  def create
    duration = (params[:task][:years].to_i * 365 * 24 * 60 * 60) +
      (params[:task][:months].to_i * 30 * 24 * 60 * 60) +
      (params[:task][:weeks].to_i * 7 * 24 * 60 * 60) +
      (params[:task][:days].to_i * 24 * 60 * 60) +
      (params[:task][:hours].to_i * 60 * 60) +
      (params[:task][:minutes].to_i * 60)

    @task = Task.new(name: params[:task][:name], duration_in_seconds: duration)

    if @task.save
      redirect_to root_path, notice: "Task was successfully created."
    else
      render "home/index", status: :unprocessable_entity
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to root_path, notice: "Task was successfully destroyed."
  end

  private

  def task_params
    params.require(:task).permit(:name, :years, :months, :weeks, :days, :hours, :minutes)
  end
end
