require 'rails_helper'

RSpec.describe WorkingDay, type: :model do
  describe ".associations" do
    it { should belong_to(:doctor) }
  end
end
