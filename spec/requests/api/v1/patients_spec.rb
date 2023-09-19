require 'rails_helper'

RSpec.describe "Api::V1::Patients", type: :request do
  let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'dkavita@mail.com') }
  let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'pkavita@mail.com') }

  describe "GET /api/v1/patients/:id/appointments" do
    context 'when valid auth token' do
      context 'when appointments present' do
        before do
          Appointment.create(date: Date.today, from_time: '19:30', to_time: '19:40', doctor: doctor, patient: patient)
          Appointment.create(date: Date.today + 8.days, from_time: '19:30', to_time: '19:40', doctor: doctor, patient: patient)
        end

        it 'should return all appointments' do
          expect(JsonWebToken).to receive(:decode).and_return({ id: patient.id })

          get "/api/v1/patients/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

          expect(response).to have_http_status(200)
          expect(response.parsed_body.size).to eq(2)
        end
      end

      context 'when appointments not available ' do
        it 'should return empty response' do
          expect(JsonWebToken).to receive(:decode).and_return({ id: patient.id })

          get "/api/v1/patients/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

          expect(response).to have_http_status(204)
        end
      end
    end

    context 'when valid auth token but user type is not patient' do
      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: doctor.id })

        get "/api/v1/patients/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end

    context 'when invalid auth token' do
      let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: 1234 })

        get "/api/v1/patients/#{doctor.id}/appointments", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end
  end
end
