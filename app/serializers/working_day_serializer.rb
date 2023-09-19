class WorkingDaySerializer < ActiveModel::Serializer
  attributes :date, :from, :to

  def from
    DateTimeUtil.time(object.from_time)
  end

  def to
    DateTimeUtil.time(object.to_time)
  end
end
