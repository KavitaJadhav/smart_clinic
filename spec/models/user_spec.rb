require 'rails_helper'

RSpec.describe User, type: :model do
  describe "#validations" do
    it { should validate_uniqueness_of(:email) }
  end

  describe '#doctor?' do
    it 'should return true when type is doctor' do
      user = User.new(type: 'Doctor')

      expect(user.doctor?).to be_truthy
    end

    it 'should return false when type is not doctor' do
      user = User.new(type: 'Patient')

      expect(user.doctor?).to be_falsey
    end
  end

  describe '#patient?' do
    it 'should return true when type is patient' do
      user = User.new(type: 'Patient')

      expect(user.patient?).to be_truthy
    end

    it 'should return false when type is not patient' do
      user = User.new(type: 'Doctor')

      expect(user.patient?).to be_falsey
    end
  end
end
