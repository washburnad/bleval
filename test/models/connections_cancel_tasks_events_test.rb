require 'test_helper'

class ConnectionsTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'Should cancel events' do
    setup
    Connections::cancel_events(@deal.events)

    @deal.events.each do |event|
      assert event.cancelled, 'Event should be canceled'
    end
  end

  test 'Should cancel tasks' do
    setup
    Connections::cancel_tasks(@deal.tasks)

    @deal.tasks.each do |task|
      assert task.task_status_id == 6, 'Task should be canceled'
    end
  end

  test 'Should not cancel all deal tasks and events' do
    setup
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
    setup
    @agent.update_attributes(autocancel_task_events_on_dead_deal: true)
    @deal.current_stage_id = 5
    @deal.save
    
    @deal.events.each do |event|
      assert event.cancelled, 'Event should be canceled'
    end

    @deal.tasks.each do |task|
      assert task.task_status_id == 6, 'Task should be canceled'
    end
  end

  def setup
    @agent = FactoryGirl.create(:agent)
    @lead = FactoryGirl.create(:lead)
    @deal = FactoryGirl.create(:deal, 
      agent: @agent,
      lead: @lead,
      current_stage_id: 3)
    3.times do
      @deal.events.create(creator_id: 1, assignee_id: 2, cancelled: false)
    end
    5.times do |n|
      @deal.tasks.create(creator_id: 1, assignee_id: 2, task_status_id: n)
    end
  end
end

