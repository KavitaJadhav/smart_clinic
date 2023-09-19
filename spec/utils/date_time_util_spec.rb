# frozen_string_literal: true

require 'rails_helper'

describe 'DateTimeUtil' do
  context '.time' do
    it 'should return time from input date' do
      datetime = DateTime.parse('10/10/2023 16:30:00')

      expect(DateTimeUtil.time(datetime)).to eq('16:30')
    end
  end
end
