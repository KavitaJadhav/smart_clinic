class Api::V1::DoctorsController < ApplicationController
  before_action :authorise_request
  before_action :requested_by_doctor, only: [:working_days]

  def working_days
    @working_days = @current_user.working_days.for_week
    render json: @working_days, each_serializer: WorkingDaySerializer, status: :ok
  end
end
