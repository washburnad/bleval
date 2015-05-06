module Connections
  # cancels (assigns status 6) to all tasks in array
  def self.cancel_tasks(tasks)
    tasks.each do |task|
      task.update_attributes(task_status_id: 6)
    end
  end

  # cancels all events in array
  def self.cancel_events(events)
    events.each do |event|
      event.update_attributes(cancelled: true)
    end
  end

  # creates a closing event
  # args requires :creator, :assignee and :deal
  def self.create_closing_event(args)
    event_params = {}
    event_params[:creator] = args[:creator]
    event_params[:assignee] = args[:assignee]
    event_params[:start_at] = args[:deal].proj_closing_date
    event_params[:deal] = args[:deal]
    event_params[:property_id] = args[:deal].property_id
    event_params[:lead] = args[:deal].lead
    event_params[:name] = 'Closing'
    event_params[:description] = %Q(
      Projected closing for property ##{args[:deal].property_id} )
    Event.create_event(event_params)
  end
end