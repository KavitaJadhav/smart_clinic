class Doctor < User
  has_many :working_days
  has_many :appointments

  def upcoming_appointments
    appointments.upcoming_week
  end

  def pending_appointments(date)
    appointments.where(date: date).pending.order(:from_time)
  end
end
