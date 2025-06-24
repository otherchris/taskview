class CalendarTasksController < ApplicationController
  def index
    @calendar_tasks = CalendarTask.all
  end
end
