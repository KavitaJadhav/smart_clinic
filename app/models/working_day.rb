class WorkingDay < ApplicationRecord
  belongs_to :doctor

  scope :for_week, -> { where(date: [Date.today..Date.today + 1.week]) }
end
