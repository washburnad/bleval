class AgentsController < ApplicationController
  def index
    @agents = Agent.all
  end

  def show
    @agent = Agent.includes(:assigned_events, 
      :created_events,
      :assigned_tasks,
      :created_tasks,
      :deals).find params[:id]
    @events = @agent.agent_events
    @deals = @agent.deals
    @tasks = @agent.agent_tasks
    @new_event = Event.new
    @new_task = Task.new
    @new_deal = Deal.new
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.create agent_params
  end

  private

  def agent_params
    params.
      require(:agent).
        permit(
          :first_name,
          :last_name)
  end
end
