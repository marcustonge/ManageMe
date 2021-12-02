require "test_helper"

class TasksControllerTest < ActionDispatch::IntegrationTest

  # Used for authenticating the user for these tests as the way the tasks controller works is that
  # a user must be authenticated before they can view any tasks
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @task = tasks(:one)
  end

  # The sign in and out is used to authenticate the testers as admin to allow access to the tasks url
  # As admins can access all pages they will be able to test this

  #tests whether the task 'create' method works correctly and
  #assigns the correct information as specified by tasks.yml :one
  test "should return correct task information upon creation" do
    sign_in users(:admin)
    task = Task.create({id: @task.id, reply: @task.reply, user_id: @task.user_id, event_id: @task.event_id})
    assert_equal 1, task.id
    assert_equal "<div>Example Task</div>", task.reply
    assert_equal 1, task.event_id
    assert_equal 1, task.user_id
    sign_out :user
  end

  #tests whether the destroy method of the task controller works
  test "should delete task" do
    sign_in users(:admin)
    assert_difference('Task.count', -1) do
      @task.destroy
    end
    sign_out :user
  end

end