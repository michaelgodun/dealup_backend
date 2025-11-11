class Api::V1::ApiBaseController < ActionController::API
  attr_reader :current_user

  before_action :authenticate_token

  private

  def authenticate_token
    payload = JsonWebToken.decode(auth_token)

    if payload[:error]
      render json: { error: [payload[:error]] }, status: :unauthorized
    else
      @current_user = User.find(payload["sub"])
    end
  end

  def auth_token
    @auth_token ||= request.headers["Authorization"]&.split(" ")&.last
  end
end