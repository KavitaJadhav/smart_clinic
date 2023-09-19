require 'rails_helper'

RSpec.describe "Api::V1::Authentications", type: :request do
  describe "POST /authentication/login" do
    context 'when valid user' do
      before do
        User.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com', type: 'Patient')
      end
      it 'should generate and return jtw token' do
        post '/api/v1/authentication/login', params: { email: 'kavita@mail.com' }

        expect(response).to have_http_status(200)
        expect(response.parsed_body['token']).not_to be_nil
      end
    end

    context 'when invalid' do
      it 'should return unauthorized error response' do
        post '/api/v1/authentication/login', params: { email: 'kavita@mail.com' }

        expect(response).to have_http_status(401)
      end
    end
  end
end
