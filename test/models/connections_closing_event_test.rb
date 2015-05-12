require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Should create closing event' do
    setup
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3)
    @closing_args = {
      creator: @agent,
      assignee: @agent,
      deal: @deal}

    Connections::create_closing_event(@closing_args)

    agent_events = @agent.events

    assert_equal 'Closing', agent_events.last.name
  end

  test 'Should create closing on deal creation' do
    setup
    @agent.update_attributes(autoadd_closing_on_deal_creation: true)
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3)
    agent_events = @agent.events

    assert_equal 'Closing', agent_events.last.name
  end

  test 'Should not create closing on deal creation' do
    setup
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3)
    agent_events = @agent.events

    refute_equal 'Closing', agent_events.last.try(:name)
  end

  def setup
    @agent = FactoryGirl.create(:agent)
    @lead = FactoryGirl.create(:lead)
  end
end

