class Api::V1::DoctorsController < ApplicationController
  before_action :authorise_request
  before_action :requested_by_doctor, only: [:working_days, :appointments]

  def working_days
    @working_days = @current_user.working_days.for_week
    render json: @working_days, each_serializer: WorkingDaySerializer, status: :ok
  end

  def appointments
    @appointments = @current_user.upcoming_appointments

    if @appointments.present?
      render json: @appointments, each_serializer: AppointmentSerializer, status: :ok
    else
      render status: :no_content
    end
  end

  def availability
    @doctor = Doctor.find(params['id'])
    working_days = @doctor.working_days.for_week
    daily_availability = {}

    working_days.each do |day|
      daily_availability[day.date] = day.availability
    end

    render json: daily_availability, status: :ok
  end
end
