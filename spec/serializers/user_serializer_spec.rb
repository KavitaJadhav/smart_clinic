require 'rails_helper'

describe 'UserSerializer' do

  describe '.attributes' do
    let(:user) { User.create(first_name: 'Kavita', last_name: 'Jadhav', email: 'kavita@mail.com', type: 'Patient') }

    it 'should return attributes specified in serializer' do
      attributes = UserSerializer.new(user).attributes
      expect(attributes).to eq({ id: user.id,
                                 first_name: user.first_name,
                                 last_name: user.last_name,
                                 email: user.email,
                                 role: user.type })
    end
  end
end
