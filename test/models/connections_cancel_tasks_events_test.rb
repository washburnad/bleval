require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Should cancel events' do
    setup_deal
    Connections::cancel_events(@deal.events)

    @deal.events.each do |event|
      assert event.cancelled, 'Event should be canceled'
    end
  end

  test 'Should cancel tasks' do
    setup_deal
    Connections::cancel_tasks(@deal.tasks)

    @deal.tasks.each do |task|
      assert task.task_status_id == 6, 'Task should be canceled'
    end
  end

  test 'Should not cancel all deal tasks and events' do
    setup_deal
    @deal.current_stage_id = 5
    @deal.save
    
    @deal.events.each do |event|
      refute event.cancelled, 'Event should not be canceled'
    end

    @deal.tasks.each do |task|
      refute task.task_status_id == 6, 'Task should not be canceled'
    end
  end

  test 'Should cancel all deal tasks and events' do
    setup_deal_autocancel

    @deal.current_stage_id = 5
    @deal.save
    @deal.reload    

    @deal.events.each do |event|
      event.reload
      assert event.cancelled, 'Event should be canceled'
    end

    @deal.tasks.each do |task|
      assert task.task_status_id == 6, 'Task should be canceled'
    end
  end

  def setup_deal
    @agent = FactoryGirl.create(:agent)
    @lead = FactoryGirl.create(:lead)
    @deal = FactoryGirl.create(:deal, 
      agent_id: @agent.id,
      lead_id: @lead.id,
      current_stage_id: 2)
    3.times do
      @deal.events.create(
        creator: @agent, 
        assignee: @agent, 
        cancelled: false)
    end
    5.times do |n|
      @deal.tasks.create(
        creator: @agent, 
        assignee: @agent,
        task_status_id: n)
    end
  end

  def setup_deal_autocancel
    @agent = FactoryGirl.create(
      :agent,
      autocancel_task_events_on_dead_deal: true)
    @lead = FactoryGirl.create(:lead)
    @deal = FactoryGirl.create(:deal, 
      agent_id: @agent.id,
      lead_id: @lead.id,
      current_stage_id: 2)
    3.times do
      @deal.events.create(
        creator: @agent, 
        assignee: @agent, 
        cancelled: false)
    end
    5.times do |n|
      @deal.tasks.create(
        creator: @agent, 
        assignee: @agent,
        task_status_id: n)
    end
  end
end

