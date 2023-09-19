class Api::V1::AppointmentsController < ApplicationController
  before_action :authorise_request
  before_action :requested_by_patient, only: [:create]

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = @current_user
    if @appointment.save
      render json: @appointment, serializer: AppointmentSerializer, status: :created
    else
      render_error_response(:unprocessable_entity, @appointment.errors.full_messages)
    end
  end

  private

  def appointment_params
    params.require(:appointment).permit!
  end
end
