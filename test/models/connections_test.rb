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

  test 'Should cancel all deal tasks and events' do
    setup
    @deal.current_stage_id = 5
    @deal.save
    @deal_stages = DealStage.all.to_a    

    @deal.events.each do |event|
      assert event.cancelled, 'Event should be canceled'
    end

    @deal.tasks.each do |task|
      assert task.task_status_id == 6, 'Task should be canceled'
    end
  end

  def setup
    @deal = Deal.create(lead_id: 1, agent_id: 1, property_id: 1, current_stage_id: 3)
    @deal.reload
    3.times do
      @deal.events.create(creator_id: 1, assignee_id: 2, cancelled: false)
    end
    5.times do |n|
      @deal.tasks.create(creator_id: 1, assignee_id: 2, task_status_id: n)
    end
  end
end

