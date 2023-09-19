class Api::V1::PatientsController < ApplicationController
  before_action :authorise_request
  before_action :requested_by_patient, only: [:appointments]

  def appointments
    @appointments = @current_user.appointments

    if @appointments.present?
      render json: @appointments, exclude_patient: true, each_serializer: AppointmentSerializer, status: :ok
    else
      render status: :no_content
    end
  end
end
