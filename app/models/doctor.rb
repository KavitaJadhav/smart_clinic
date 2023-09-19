class Doctor < User
  has_many :working_days
  has_many :appointments

  def upcoming_appointments
    appointments.upcoming_week
  end
end
