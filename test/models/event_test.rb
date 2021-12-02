require "test_helper"

class EventTest < ActiveSupport::TestCase
  
  setup do
    @event = events(:one)
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

  #Can't test times as it does not work in the assert equal
  #field and for a reason most likely related to events being
  #related to users I cannot set the event user this way
  test "should create an event with the correct attributes" do
    event = Event.create({name: @event.name, description: @event.description,
    start_time: @event.start_time, end_time: @event.end_time,
    user: @event.user})
    
    assert_equal "MyString", event.name
    assert_equal "Test description", event.description

  end
end
