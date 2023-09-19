require 'rails_helper'

RSpec.describe WorkingDay, type: :model do
  describe '.associations' do
    it { should belong_to(:doctor) }
  end

  describe '#availability' do
    context 'when not appointments for the day' do
      it 'should return all slots' do
        doctor = double('Doctor', pending_appointments: [])
        working_day = WorkingDay.new(date: Date.today, from_time: '10:00', to_time: '11:00')
        expect(working_day).to receive(:doctor).and_return(doctor)

        expect(working_day.availability).to eq(['10:00', '10:15', '10:30', '10:45'])
      end
    end

    context 'when start_time and end_time falls to different day' do
      it 'should return all slots' do
        doctor = double('Doctor', pending_appointments: [])
        working_day = WorkingDay.new(date: Date.today, from_time: '23:30', to_time: '00:30')

        expect(working_day).to receive(:doctor).and_return(doctor)

        expect(working_day.availability).to eq(['23:30', '23:45', '00:00', '00:15'])
      end
    end

    context 'when appointments are scheduled on the day' do
      it 'should return all remaining slots' do
        appointment1 = Appointment.new( from_time: '10:00', to_time: '10:15')
        appointment2 = Appointment.new(  from_time: '10:30', to_time: '10:45')
        doctor = double('Doctor', pending_appointments: [appointment1, appointment2])
        working_day = WorkingDay.new(date: Date.today, from_time: '10:00', to_time: '11:00')

        expect(working_day).to receive(:doctor).and_return(doctor)

        expect(working_day.availability).to eq(['10:15', '10:45'])
      end
    end
  end
end
