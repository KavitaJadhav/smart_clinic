class User < ApplicationRecord
  validates :email, uniqueness: true

  def doctor?
    type == 'Doctor'
  end

  def patient?
    type == 'Patient'
  end
end
