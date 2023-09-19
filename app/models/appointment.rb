class Appointment < ApplicationRecord
  module STATUS
    Created = 'Created'
    Canceled = 'Cancelled'
    Completed = 'Completed'
  end

  belongs_to :doctor
  belongs_to :patient

  before_create :set_status

  private

  def set_status
    assign_attributes(status: STATUS::Created)
  end
end
