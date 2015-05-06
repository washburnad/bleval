module ApplicationHelper
  def event_details(event)
    %Q( Event ID: #{event.id} -  
        Deal ID: #{event.deal_id} -
        Cancelled? #{event.cancelled} ) 
  end

  def task_details(task)
    %Q( Task ID: #{task.id} -  
        Deal ID: #{task.deal_id} -
        Priority: #{task.priority.name} -
        Status: #{task.task_status.name}) 
  end

  def deal_details(deal)
    %Q( Deal ID: #{deal.id} -  
        Stage: #{deal.current_stage.name}) 
  end
end
