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

  def events
    ( assigned_events.to_a + created_events.to_a ).uniq
  end

  def tasks
    ( assigned_tasks.to_a + created_tasks.to_a ).uniq
  end
end