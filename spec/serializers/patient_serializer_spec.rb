require 'rails_helper'

describe 'PatientSerializer' do

  describe '.attributes' do
    let(:patient) { Patient.new(first_name: 'kavita', last_name: 'Jadhav', email: 'kavita@mail.com') }

    it 'should return attributes specified in serializer' do
      attributes = PatientSerializer.new(patient).attributes
      expect(attributes).to eq({ first_name: patient.first_name,
                                 last_name: patient.last_name,
                                 email: patient.email })
    end
  end
end
