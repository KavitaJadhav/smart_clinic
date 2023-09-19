class AppointmentSerializer < ActiveModel::Serializer
  attributes :id, :status, :date, :from, :to
  has_one :patient

  def from
    DateTimeUtil.time(object.from_time)
  end

  def to
    DateTimeUtil.time(object.to_time)
  end
end
