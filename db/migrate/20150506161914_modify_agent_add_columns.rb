class ModifyAgentAddColumns < ActiveRecord::Migration
  def change
    add_column :agents, :autocancel_task_events_on_dead_deal, :boolean, default: :false
    add_column :agents, :autocreate_lead_followup_task, :boolean, default: :false
    add_column :agents, :autoadd_closing_on_deal_creation, :boolean, default: :false
  end
end
