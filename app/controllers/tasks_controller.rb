class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all
  end

  def create
    @task = Task.create task_params
    if @task.valid?
      redirect_to task_path @task 
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @task = Task.find params[:id]
  end

  def edit
    @task = Task.find params[:id]
  end

  def update
    @task = Task.find params[:id]
    @task.update_attributes task_params
    if @task.valid?
      redirect_to task_path @task 
    else
      render :new, :status => :unprocessable_entity
    end
  end
    
  private

  def task_params
    params.require(:task).
      permit(:creator_id, 
        :assignee_id, 
        :completer_id, 
        :lead_id, 
        :deal_id, 
        :task_priority_id, 
        :task_status_id,
        :name,
        :description)
  end
end
