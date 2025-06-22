class HomeController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
    @completions = Completion.includes(:task).all
  end
end
