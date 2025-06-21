class HomeController < ApplicationController
  def index
    @task = Task.new
    @tasks = Task.all
  end
end
