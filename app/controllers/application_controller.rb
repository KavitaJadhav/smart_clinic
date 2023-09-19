class ApplicationController < ActionController::API
  private

  def authorise_request
    auth_header = request.headers['Authorization']
    auth_token = auth_header.split(' ').last if auth_header

    begin
      payload = JsonWebToken.decode(auth_token)
      user = User.find(payload[:id])
      @current_user = user.type.constantize.find(user.id)
    rescue ActiveRecord::RecordNotFound => e
      render_error_response(:unauthorized, error_message = e.message)
    rescue JWT::DecodeError => e
      render_error_response(:unauthorized, error_message = e.message)
    end
  end

  def render_error_response(status, error_message = nil)
    render json: { error: error_message }, status: status
  end

  def requested_by_doctor
    render_error_response(:unauthorized, I18n.t('messages.error.unauthorised')) unless @current_user.doctor?
  end

  def requested_by_patient
    render_error_response(:unauthorized, I18n.t('messages.error.unauthorised')) unless @current_user.patient?
  end

end
