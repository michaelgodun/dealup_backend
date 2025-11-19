class Api::V1::AuthController < Api::V1::ApiBaseController
  skip_before_action :authenticate_token, only: [ :create, :register, :refresh ]

  def create
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      access_token = JsonWebToken.encode({ sub: user.id })
      refresh_token = JsonWebToken.encode({ sub: user.id }, 7.days.from_now)
      user.update!(refresh_token: refresh_token)
      render json: { user: { id: user.id, username: user.username, email: user.email, admin: user.admin? }, access_token: access_token, refresh_token: refresh_token }, status: :ok
    else
      render json: { errors: [ "Invalid email or password" ] }, status: :unauthorized
    end
  end
  def refresh
    refresh_token = params[:refresh_token]
    decoded = JsonWebToken.decode(refresh_token)
    user = User.find(decoded["sub"])
    if user && user.refresh_token == refresh_token
      access_token = JsonWebToken.encode({ sub: user.id })
      render json: { access_token: access_token }, status: :ok
    else
      render json: { errors: [ "Invalid refresh token" ] }, status: :unauthorized
    end
  rescue
    render json: { errors: [ "Invalid refresh token" ] }, status: :unauthorized
  end

  def register
    user = User.new(register_params)

    if user.save
      access_token = JsonWebToken.encode({ sub: user.id })
      refresh_token = JsonWebToken.encode({ sub: user.id }, 7.days.from_now)
      user.update!(refresh_token: refresh_token)

      render json: {
        user: { id: user.id, username: user.username, email: user.email },
        access_token: access_token,
        refresh_token: refresh_token
      }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def register_params
    params.permit(:username, :email, :password, :password_confirmation)
  end
end