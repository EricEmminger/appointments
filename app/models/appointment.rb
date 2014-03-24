class Appointment < ActiveRecord::Base
  attr_accessor :imported
  validates :start_time, presence: true, uniqueness: true
  validates :end_time, presence: true, uniqueness: true
  validates :start_time, date: true, unless: :imported
  validates :end_time, date: true, unless: :imported
  validate :start_time_cannot_overlap

  def start_time_cannot_overlap
    a = Appointment.where("start_time <= ? AND end_time > ?", start_time, start_time).take
    if a
      errors.add(:start_time, "cannot overlap an existing appointment")
    end
  end
end
