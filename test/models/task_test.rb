require "test_helper"

class TaskTest < ActiveSupport::TestCase

  def setup
    @task = tasks(:one)
  end

  #tests whether the task 'create' method works correctly and
  #assigns the correct information as specified by tasks.yml :one
  test "should be a valid task" do
    assert_equal 1, @task.id
    assert_equal "<div>Example Task</div>", @task.reply
    assert_equal 1, @task.event_id
    assert_equal 1, @task.user_id
  end

  #tests whether the destroy method works
  test "should delete task" do
    assert_difference('Task.count', -1) do
      @task.destroy
    end
  end

  #a task should not be able to be saved if it has no attributes
  test "should not save task with no parameters" do
      task = Task.new
      assert_not task.save
  end

end
