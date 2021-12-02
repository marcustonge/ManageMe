require "test_helper"

class EventsControllerTest < ActionDispatch::IntegrationTest

  # Used for authenticating the user for these tests as the way the events controller works is that
  # a user must be authenticated before they can view any events
  include Devise::Test::IntegrationHelpers

  setup do
    @event = events(:one)
  end

  # The sign in and out is used to authenticate the testers as admin to allow access to the events url
  # As admins can access all pages they will be able to test this
  test "should get index" do
    sign_in users(:admin)
    get events_url
    assert_response :success
    sign_out :user
  end
  
  test "should create event" do
    sign_in users(:admin)
    assert_difference('Event.count') do
      post events_url, params: { event: { name: @event.name, description: @event.description, start_time: @event.start_time, end_time: @event.end_time, user_id: @event.user_id } }
    end

    assert_redirected_to event_url(Event.last)
    sign_out :user
  end

  test "should show event" do
    sign_in users(:admin)
    get event_url(@event)
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


end
