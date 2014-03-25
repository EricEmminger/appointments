require 'test_helper'

class AppointmentsControllerTest < ActionController::TestCase
  setup do
    @appointment = appointments(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:appointments)
    tomorrow = appointments(:tomorrow)
    assert_equal tomorrow.start_time, assigns(:appointments)[0].start_time
    assert_equal @appointment.start_time, assigns(:appointments)[1].start_time
  end

  test "should accept start time" do
    get :index, {start_time: Date.today + 1}
    assert_response :success
    assert_not_nil assigns(:appointments)
    @appointment = appointments(:tomorrow)
    assert_equal @appointment.start_time, assigns(:appointments)[0].start_time
  end

  test "should accept end time" do
    get :index, {end_time: Date.today + 1}
    assert_response :success
    assert_not_nil assigns(:appointments)
    @appointment = appointments(:tomorrow)
    assert_equal @appointment.end_time, assigns(:appointments)[0].end_time
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create appointment" do
    @appointment.start_time = Date.today + 3
    @appointment.end_time = @appointment.start_time
    assert_difference('Appointment.count') do
      post :create, appointment: { comments: @appointment.comments, end_time: @appointment.end_time, first_name: @appointment.first_name, last_name: @appointment.last_name, start_time: @appointment.start_time }
    end

    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should show appointment" do
    get :show, id: @appointment
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @appointment
    assert_response :success
  end

  test "should update appointment" do
    patch :update, id: @appointment, appointment: { comments: @appointment.comments, end_time: @appointment.end_time, first_name: @appointment.first_name, last_name: @appointment.last_name, start_time: @appointment.start_time }
    assert_redirected_to appointment_path(assigns(:appointment))
  end

  test "should destroy appointment" do
    assert_difference('Appointment.count', -1) do
      delete :destroy, id: @appointment
    end

    assert_redirected_to appointments_path
  end
end
