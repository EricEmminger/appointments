require 'test_helper'

class AppointmentTest < ActiveSupport::TestCase
  test "should have future start and end times" do
    a = Appointment.new
    assert_not a.valid?
    assert_not a.errors[:start_time].empty?
    a.start_time = Date.today + 3
    assert_not a.valid?
    assert a.errors[:start_time].empty?
    assert_not a.errors[:end_time].empty?
    a.end_time = Date.today + 3
    assert a.valid?
    assert a.save
  end

  test "tomorrow" do
    @appointment = appointments(:tomorrow)
    assert_equal Date.today + 1, @appointment.start_time
  end

  test "should not overlap" do
    a = Appointment.new
    a.start_time = Date.today + 3
    a.end_time = a.start_time + 60 * 5
    b = a.clone
    c = a.clone
    assert a.save
    assert_not b.save
    c.start_time += 60
    c.end_time -= 60
    assert_not c.save
  end
end
