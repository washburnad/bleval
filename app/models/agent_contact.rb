class AgentContact < ActiveRecord::Base
  belongs_to :agent
  belongs_to :lead
  validates_presence_of :lead_id
  validates_presence_of :agent_id

  after_create :assign_contact_task

  include Connections

  private

  def assign_contact_task
    Connections::create_agent_contact_task(
      { creator: agent,
        assignee: agent,
        lead: lead,
        description: comments })
  end
end