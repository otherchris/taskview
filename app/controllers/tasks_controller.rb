class TasksController < ApplicationController
  def create
    @task = Task.new(task_params)

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
    params.require(:task).permit(:name, :daily, :interval_in_seconds)
  end
end
