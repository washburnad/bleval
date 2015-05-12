module Connections
  include Timing
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
    event_params = args.
      slice(
        :creator, 
        :assignee, 
        :deal).
      merge(
        property_id: args[:deal].property_id,
        lead: args[:deal].lead,
        name: 'Closing',
        description: %Q( Projected closing for property ##{args[:deal].property_id} ) )
    Event.create_event(event_params)
  end

  # creates a new task after agent contact
  # args requires :creator, :assignee, :lead, :description
  def self.create_agent_contact_task(args)
    puts 'in create agent contact task'
    p args
    task_params = {}
    task_params[:creator] = args[:creator]
    task_params[:assignee] = args[:assignee]
    task_params[:lead] = args[:lead]
    task_params[:name] = 'Contact lead'
    task_params[:description] = args[:description]
    task_params[:due_date] = Timing::in_one_day
    task_params[:task_priority_id] = 2
    task_params[:task_status_id] = 1
    Task.create_task(task_params)
  end
end