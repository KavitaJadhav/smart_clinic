require 'rails_helper'

RSpec.describe "Api::V1::Doctors", type: :request do
  let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'dkavita@mail.com') }
  let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'pkavita@mail.com') }

  describe "GET /api/v1/doctors/:id/working_days" do
    context 'when valid auth token' do
      let!(:working_day1) { WorkingDay.create(doctor_id: doctor.id, date: Date.today, from_time: Time.now, to_time: Time.now + 5.hours) }
      let!(:working_day2) { WorkingDay.create(doctor_id: doctor.id, date: Date.today + 8.days, from_time: Time.now, to_time: Time.now + 5.hours) }

      it 'should return doctors schedule' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: doctor.id })

        get "/api/v1/doctors/#{doctor.id}/working_days", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(200)
        expect(response.parsed_body.size).to eq(1)
      end
    end

    context 'when valid auth token but user type is not doctor' do
      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: patient.id })

        get "/api/v1/doctors/1/working_days", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end

    context 'when invalid auth token' do
      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: 1234 })

        get "/api/v1/doctors/1/working_days", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET /api/v1/doctors/:id/appointments" do
    context 'when valid auth token' do
      context 'when appointments present' do
        before do
          appointment1 = Appointment.create(date: Date.today, from_time: '19:30', to_time: '19:40', doctor: doctor, patient: patient)
          appointment2 = Appointment.create(date: Date.today, from_time: '19:30', to_time: '19:40', doctor: doctor, patient: patient)
          appointment2.cancel
          appointment3 = Appointment.create(date: Date.today + 8.days, from_time: '19:30', to_time: '19:40', doctor: doctor, patient: patient)
        end

        it 'should return upcoming appointments schedule' do
          expect(JsonWebToken).to receive(:decode).and_return({ id: doctor.id })

          get "/api/v1/doctors/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

          expect(response).to have_http_status(200)
          expect(response.parsed_body.size).to eq(1)
        end
      end

      context 'when appointments not available ' do
        it 'should return empty response' do
          expect(JsonWebToken).to receive(:decode).and_return({ id: doctor.id })

          get "/api/v1/doctors/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

          expect(response).to have_http_status(204)
        end
      end
    end

    context 'when valid auth token but user type is not doctor' do
      let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: patient.id })

        get "/api/v1/doctors/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end

    context 'when invalid auth token' do
      let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: 1234 })

        get "/api/v1/doctors/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end
  end

  describe "GET /api/v1/doctors/:id/availability" do
    let!(:working_day1) { WorkingDay.create(doctor_id: doctor.id, date: Date.today, from_time: '10:00', to_time: '11:00') }
    let!(:working_day2) { WorkingDay.create(doctor_id: doctor.id, date: Date.today + 1.day, from_time: '10:00', to_time: '11:00') }

    context 'when valid auth token' do
      it 'should return upcoming appointments schedule' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: doctor.id })

        get "/api/v1/doctors/#{doctor.id}/availability", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(200)
        expect(response.parsed_body.size).to eq(2)
      end
    end

    context 'when invalid auth token' do
      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: 1234 })

        get "/api/v1/doctors/#{doctor.id}/availability", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end
  end
end
