class AgentsController < ApplicationController
  def index
    @agents = Agent.all
  end

  def show
    @agent = Agent.includes(:assigned_events, 
      :created_events,
      :assigned_tasks,
      :created_tasks,
      :deals,
      :leads).find params[:id]
    @events = @agent.agent_events
    @deals = @agent.deals
    @tasks = @agent.agent_tasks
    @leads = @agent.leads
    @new_event = Event.new
    @new_task = Task.new
    @new_deal = Deal.new
    @new_lead = Lead.new
  end

  def new
    @agent = Agent.new
  end

  def create
    @agent = Agent.create agent_params
    if @agent.valid?
      redirect_to agent_path @agent
    else
      render :new, status: :unprocessable_entity
    end
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
