require 'test_helper'

class AgentTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test 'Should return all agent events' do
    setup

    assert_equal 3, @agent.created_events.count, 'Should count all created events'
    assert_equal 2, @agent.assigned_events.count, 'Should count all assigned events'
    assert_equal 5, @agent.events.count, 'Should count all agent events'
  end

  test 'Should return all agent tasks' do
    setup
    
    assert_equal 1, @agent.created_tasks.count, 'Should count all created events'
    assert_equal 5, @agent.assigned_tasks.count, 'Should count all assigned events'
    assert_equal 6, @agent.tasks.count, 'Should count all agent events'
  end

  def setup
    @agent = FactoryGirl.create(:agent)
    @lead = FactoryGirl.create(:lead)
    3.times do |n|
      FactoryGirl.create(
        :event,
        creator_id: @agent.id,
        assignee_id: 99)
    end
    2.times do |n|
      FactoryGirl.create(
        :event,
        creator_id: 99,
        assignee_id: @agent.id)
    end
    1.times do |n|
      FactoryGirl.create(
        :task,
        creator_id: @agent.id,
        assignee_id: 99)
    end
    5.times do |n|
      FactoryGirl.create(
        :task,
        creator_id: 99,
        assignee_id: @agent.id)
    end
    @agent.reload
  end
end
