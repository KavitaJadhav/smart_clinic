require 'rails_helper'

RSpec.describe Patient, type: :model do
  describe ".associations" do
    it { should have_many(:appointments) }
  end
end
