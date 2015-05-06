class Agent < ActiveRecord::Base
  has_many :deals
  has_many :leads
  has_many :showings
  has_many :agent_contacts
  has_many :assigned_events, :class_name => "Event", :foreign_key => :assignee_id
  has_many :created_events, :class_name => "Event", :foreign_key => :creator_id
  has_many :assigned_tasks, :class_name => "Task", :foreign_key => :assignee_id
  has_many :created_tasks, :class_name => "Task", :foreign_key => :creator_id
  has_many :completed_tasks, :class_name => "Task", :foreign_key => :completer_id

  def agent_events
    assigned_events.push(created_events).uniq
  end

  def agent_tasks
    assigned_tasks.push(created_tasks).uniq
  end
end