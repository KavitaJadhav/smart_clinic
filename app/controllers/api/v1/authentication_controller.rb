class Api::V1::AuthenticationController < ApplicationController
  def login
    @user = User.find_by_email(login_params['email'])
    if @user
      jwt_token = JsonWebToken.encode(UserSerializer.new(@user).attributes)
      render json: { token: jwt_token }, status: :ok
    else
      render json: { error: I18n.t('messages.error.invalid_creds') }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:email)
  end
end