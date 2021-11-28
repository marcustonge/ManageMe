require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @event = events(:one)
  end

  test "should get index" do
    get events_url
    assert_response :success
  end
  
  test "should create event" do
    assert_difference('Event.count') do
      post events_url, params: { event: { end_time: @event.end_time, name: @event.name, start_time: @event.start_time, user_id: @event.user_id } }
    end

    assert_redirected_to event_url(Event.last)
  end

  test "should show event" do
    get event_url(@event)
    assert_response :success
  end

  
  # test "should get edit" do
  #   get edit_event_url(@event)
  #   assert_response :success
  # end

  test "should update event" do
    patch event_url(@event), params: { event: { end_time: @event.end_time, name: @event.name, start_time: @event.start_time, user_id: @event.user_id } }
    assert_redirected_to event_url(@event)
  end

  test "should destroy event" do
    assert_difference('Event.length', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
  end

  #can't test 'get new' as the way my website is designed means that you need to be logged
  #in to view events that are visible to your account so this test has been excluded
  test "should get new" do
    get new_event_url, headers: { Authorization: ActionController::HttpAuthentication::Basic.encode_credentials('dhh', 'secret') }
    assert_response :success
  end

end
