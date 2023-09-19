require 'rails_helper'

describe 'AppointmentSerializer' do

  describe '.attributes' do
    let(:appointment) { Appointment.new(date: Date.today, from_time: Time.now, to_time: Time.now + 5.hours, id: 1, status: Appointment::STATUS::Created) }

    it 'should return attributes specified in serializer' do
      attributes = AppointmentSerializer.new(appointment).attributes
      expect(attributes).to eq({ id: 1,
                                 status: Appointment::STATUS::Created,
                                 date: appointment.date,
                                 to: DateTimeUtil.time(appointment.to_time),
                                 from: DateTimeUtil.time(appointment.from_time) })
    end
  end
end
