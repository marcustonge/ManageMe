require "test_helper"

class EventTest < ActiveSupport::TestCase
  
  setup do
    @event = events(:one)
    @event2 = events(:two)
    @event3 = events(:invalid)
  end

  test "should create valid event" do
    assert @event.valid?
  end
  
  test "should create invalid event" do
    assert_not @event3.valid?
  end

  #an event with no parameters such as name, start time, end time
  #should not be able to be saved, an event with no description can be saved
  #as it is not required
  test "should not save an event with no parameters" do
    event = Event.new
    assert_not event.save
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      @event.destroy
    end
  end

  test "should create valid event with description" do
    assert @event.valid?
  end

  test "should create valid event without description" do
    assert @event2.valid?
  end
  
  
  
end
