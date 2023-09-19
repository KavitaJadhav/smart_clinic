class WorkingDay < ApplicationRecord
  belongs_to :doctor

  scope :for_week, -> { where(date: [Date.today..Date.today + 1.week]) }

  def availability
    slots = []

    start_time = from_time
    end_time = to_time

    end_time = end_time + 1.day if start_time > end_time

    daily_appointments = doctor.pending_appointments(date)
    if daily_appointments.empty?
      while end_time > start_time do
        slots << DateTimeUtil.time(start_time)
        start_time = start_time + APPLICATION_CONFIGS['appointment_duration_in_minutes'].minutes
      end
      return slots
    end

    next_appointment = daily_appointments[0]
    appointment_index = 0
    while end_time > start_time do
      slot_end_time = start_time + APPLICATION_CONFIGS['appointment_duration_in_minutes'].minutes
      if next_appointment && slot_end_time > next_appointment.from_time
        start_time = next_appointment.to_time
        appointment_index = appointment_index + 1
        next_appointment = daily_appointments[appointment_index]
      else
        slots << DateTimeUtil.time(start_time)
        start_time = start_time + APPLICATION_CONFIGS['appointment_duration_in_minutes'].minutes
      end
    end

    slots
  end
end
