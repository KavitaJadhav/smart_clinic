require 'rails_helper'

RSpec.describe "Api::V1::Appointments", type: :request do
  describe "POST /api/v1/appointments" do
    let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'pkavita@mail.com') }
    let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'dkavita@mail.com') }

    context 'when valid auth token' do
      it 'should create appointment' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: patient.id })

        expect do
          post "/api/v1/appointments", params: { appointment: { date: '19/09/2023', from_time: '19:30', to_time: '19:40', doctor_id: doctor.id } }, headers: { 'Authorization' => 'abc def' }
        end.to change { Appointment.count }.from(0).to(1)

        expect(response).to have_http_status(201)
      end
    end

    context 'when valid auth token but user type is not patient' do
      # let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: doctor.id })

        post "/api/v1/appointments", params: { appointment: { date: '19/09/2023', from_time: '19:30', to_time: '19:40', doctor_id: doctor.id } }, headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end

    context 'when invalid auth token' do
      let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: 1234 })

        post "/api/v1/appointments", params: { appointment: { date: '19/09/2023', from_time: '19:30', to_time: '19:40', doctor_id: doctor.id } }, headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end

  end

end
