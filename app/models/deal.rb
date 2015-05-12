class Deal < ActiveRecord::Base
  belongs_to :lead
  belongs_to :agent
  belongs_to :current_stage, :class_name => 'DealStage'
  has_many :events
  has_many :tasks
  validates_presence_of :lead_id
  validates_presence_of :agent_id
  validates_presence_of :property_id

  after_save :update_deal_connections
  after_create :new_deal_connections

  include Connections

  def stage
    current_stage.try(:name)
  end

  private

  def update_deal_connections
    if (agent.autocancel_task_events_on_dead_deal &&
        current_stage.present? && 
        current_stage.dead)
          Connections::cancel_tasks(tasks)
          Connections::cancel_events(events)
    end
  end

  def new_deal_connections
    if agent.autoadd_closing_on_deal_creation
      Connections::create_closing_event(
        {deal: self, assignee: agent, creator: agent})
    end

    if agent.autocreate_ps_task
      Connections::create_ps_signing_task(
        {deal: self, assignee: agent, creator: agent, lead: lead})
    end
  end
end