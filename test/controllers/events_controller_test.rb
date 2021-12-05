require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest

  # Used for authenticating the user for these tests as the way the events controller works is that
  # a user must be authenticated before they can view any events
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
    @event2 = events(:two)
  end

  # The sign in and out is used to authenticate the testers as admin to allow access to the events url
  # As admins can access all pages they will be able to test this
  test "should get index" do
    sign_in users(:admin)
    get events_url
    assert_response :success
    sign_out :user
  end
  
  test "should create event with description" do
    sign_in users(:admin)
    assert_difference('Event.count') do
      post events_url, params: { event: { name: @event.name, description: @event.description, start_time: @event.start_time, end_time: @event.end_time, user_id: @event.user_id } }
    end

    assert_redirected_to event_url(Event.last)

    get event_url(Event.last)
    assert_select 'h1', @event.name
    assert_select 'p', "Event description:  " + @event.description

    sign_out :user
  end

  test "should show event" do
    sign_in users(:admin)
    get event_url(@event)
    assert_select 'h1', @event.name
    assert_select 'p', "Event description:  " + @event.description
    assert_response :success
    sign_out :user
  end

  
  test "should get edit" do
    sign_in users(:admin)
    get edit_event_url(@event)
    assert_response :success
    sign_out :user
  end

  test "should destroy event" do
    sign_in users(:admin)
    assert_difference('Event.count', -1) do
      delete event_url(@event)
    end

    assert_redirected_to events_url
    sign_out :user
  end

  test "should get new" do
    sign_in users(:admin)
    get new_event_url
    assert_select 'h1', "Schedule a new Event"
    assert_select 'p', "Schedule a new Event by filling in the details below."

    assert_response :success
    sign_out :user
  end

  #Tests if authentication on the website works, if you're not authenticated
  #you should not be able to access any events but if you are then you can

  test 'authenticated users can get events url' do
    sign_in users(:normal_user)
    get events_url
    assert_response :success
    sign_out :user
  end

  test 'un-authenticated users can not get events url' do
    get events_url
    assert_response 302
  end

  test "should create event without description" do
    sign_in users(:admin)
    assert_difference('Event.count') do
      post events_url, params: { event: 
      { name: @event2.name, start_time: @event2.start_time, 
      end_time: @event2.end_time, user_id: @event2.user_id } }
    end

    assert_redirected_to event_url(Event.last)
    
    get event_url(Event.last)
    assert_select 'h1', @event.name
    assert_select 'p', {count: 0, text: "Event description:  " + @event.description}

    sign_out :user
  end

  test "should return correct event information upon creation" do
    sign_in users(:admin)
    
    assert @event.valid?

    get event_url(@event)
    assert_select 'h1', @event.name
    
    sign_out :user
  end

end
