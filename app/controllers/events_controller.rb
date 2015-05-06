class EventsController < ApplicationController
  def new
    @event = Event.new
  end

  def index
    @events = Event.all
  end

  def create
    @event = Event.create event_params
    if @event.valid?
      redirect_to event_path @event 
    else
      render :new, :status => :unprocessable_entity
    end
  end

  def show
    @event = Event.find params[:id]
  end

  def edit
    @event = Event.find params[:id]
  end

  def update
    @event = Event.find params[:id]
    @event.update_attributes event_params
    if @event.valid?
      redirect_to event_path @event 
    else
      render :new, :status => :unprocessable_entity
    end
  end

  private

  def event_params
    params.require(:event).
      permit(:creator_id, 
        :assignee_id, 
        :lead_id, 
        :deal_id,
        :name,
        :description)
  end
end
