class AlterAgentsAddAutocreatePsTask < ActiveRecord::Migration
  def change
    add_column :agents, :autocreate_ps_task, :boolean, default: false
  end
end
