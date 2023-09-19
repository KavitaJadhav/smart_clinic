class Api::V1::AppointmentsController < ApplicationController
  before_action :authorise_request
  before_action :get_appointment, only: [:update, :cancel]
  before_action :requested_by_patient, only: [:create, :update]
  before_action :requested_by_patient_or_doctor, only: [:cancel]

  def create
    @appointment = Appointment.new(appointment_params)
    @appointment.patient = @current_user
    if @appointment.save
      render json: @appointment, serializer: AppointmentSerializer, status: :created
    else
      render_error_response(:unprocessable_entity, @appointment.errors.full_messages)
    end
  end

  def update
    if @appointment.update(appointment_params)
      render json: @appointment, serializer: AppointmentSerializer, status: :ok
    else
      render_error_response(:unprocessable_entity, @appointment.errors.full_messages)
    end
  end

  def cancel
    if @appointment.cancel
      render json: @appointment, serializer: AppointmentSerializer, status: :ok
    else
      render_error_response(:unprocessable_entity, @appointment.errors.full_messages)
    end
  end

  private

  def get_appointment
    @appointment = Appointment.find(params['id'])
  end

  def appointment_params
    params.require(:appointment).permit!
  end

  def requested_by_patient_or_doctor
    render_error_response(:unauthorized, I18n.t('messages.error.unauthorized')) unless (@current_user.patient? && @appointment.patient_id == @current_user.id) || @appointment.doctor_id == @current_user.id
  end
end
