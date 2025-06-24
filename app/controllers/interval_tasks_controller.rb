class IntervalTasksController < ApplicationController
  def index
    @interval_tasks = IntervalTask.all
  end
end
