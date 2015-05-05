class AgentsController < ApplicationController
  def index
    @agents = Agent.all.to_a
  end

  def show
    @agent = Agent.find params[:id]
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
