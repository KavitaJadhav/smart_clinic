class DateTimeUtil
  def self.time(datetime)
    datetime.strftime("%H:%M")
  end
end