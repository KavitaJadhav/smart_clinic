require 'rails_helper'

RSpec.describe "Api::V1::Doctors", type: :request do
  describe "GET /working_days" do
    context 'when valid auth token' do
      let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }
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
      let(:patient) { Patient.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: patient.id })

        get "/api/v1/doctors/1/working_days", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end

    context 'when invalid auth token' do
      let(:doctor) { Doctor.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

      it 'should return unauthorized error response' do
        expect(JsonWebToken).to receive(:decode).and_return({ id: 1234 })

        get "/api/v1/doctors/1/working_days", headers: { 'Authorization' => 'abc def' }

        expect(response).to have_http_status(401)
      end
    end
  end
end
