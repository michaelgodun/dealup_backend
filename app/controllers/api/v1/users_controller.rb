class Api::V1::UsersController < Api::V1::ApiBaseController
  skip_before_action :authenticate_token, only: [:show]
  load_and_authorize_resource
  def show
  end

  def recent_activity

  end
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :avatar)
  end
end