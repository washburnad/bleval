require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Should create ps task' do
    setup_agent_lead
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3,
      ps_date: Time.new(2015, 12, 31))
    @ps_task_args = {
      creator: @agent,
      assignee: @agent,
      lead: @lead,
      deal: @deal,
      description: 'PS signing' }

    Connections::create_ps_signing_task(@ps_task_args)

    last_task = @agent.tasks.last

    assert_equal 'Sign P&S', last_task.try(:name)
  end

  test 'Should create ps task on deal creation' do
    setup_agent_lead
    @agent.update_attributes(autocreate_ps_task: true)
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3,
      ps_date: Time.new(2015, 12, 31))
    last_task = @agent.tasks.last

    assert_equal 'Sign P&S', last_task.try(:name)  
  end

  test 'Should not create ps task on deal creation' do
    setup_agent_lead
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3,
      ps_date: Time.new(2015, 12, 31))
    last_task = @agent.tasks.last

    refute_equal 'Sign P&S', last_task.try(:name)
  end

  def setup_agent_lead
    @agent = FactoryGirl.create(:agent)
    @lead = FactoryGirl.create(:lead)
  end
end

