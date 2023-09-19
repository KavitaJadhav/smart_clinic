require 'rails_helper'

RSpec.describe Appointment, type: :model do
  let(:appointment) { Appointment.new }

  describe '.associations' do
    it { should belong_to(:doctor) }
    it { should belong_to(:patient) }
  end

  describe '.callbacks' do
    context 'before_create#set_status' do
      let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'dkavita@mail.com') }
      let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'pkavita@mail.com') }

      it 'should set status as created' do
        appointment = Appointment.new(date: Date.today, from_time: Time.now, to_time: Time.now + 5.hours, id: 1, doctor: doctor, patient: patient)
        appointment.save(validate: false)

        expect(appointment.status).to eq(Appointment::STATUS::Created)
      end
    end
  end

  describe '#cancel' do
    it 'it should cancel an appointment' do
      expect(appointment).to receive(:update).with(status: Appointment::STATUS::Canceled)

      appointment.cancel
    end
  end
end
