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

  include Connections

  private

  def update_deal_connections
    if current_stage.present? && current_stage_id == 5
      Connections::cancel_tasks(tasks)
      Connections::cancel_events(events)
    end
  end
end