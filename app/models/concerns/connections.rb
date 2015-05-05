module Connections
  def self.cancel_tasks(tasks)
    tasks.each do |task|
      task.update_attributes(task_status_id: 6)
    end
  end

  def self.cancel_events(events)
    events.each do |event|
      event.update_attributes(cancelled: true)
    end
  end
end