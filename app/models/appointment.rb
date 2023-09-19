class Appointment < ApplicationRecord
  module STATUS
    Created = 'Created'
    Canceled = 'Cancelled'
    Completed = 'Completed'
  end

  belongs_to :doctor
  belongs_to :patient

  before_create :set_status

  scope :upcoming_week, -> { where(date: [Date.today..Date.today + 1.week], status: STATUS::Created) }

  def cancel
    update(status: STATUS::Canceled)
  end

  private

  def set_status
    assign_attributes(status: STATUS::Created)
  end
end
