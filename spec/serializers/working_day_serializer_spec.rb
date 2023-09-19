require 'rails_helper'

describe 'WorkingDaySerializer' do

  describe '.attributes' do
    let(:working_day) { WorkingDay.new(date: Date.today, from_time: Time.now, to_time: Time.now + 5.hours) }

    it 'should return attributes specified in serializer' do
      attributes = WorkingDaySerializer.new(working_day).attributes
      expect(attributes).to eq({ date: working_day.date,
                                 to: DateTimeUtil.time(working_day.to_time),
                                 from: DateTimeUtil.time(working_day.from_time) })
    end
  end
end
