class Api::V1::Admin::BaseController < Api::V1::ApiBaseController
  before_action :authorize_admin!

  private

  def authorize_admin!
    return if current_user&.admin?

    render json: { error: "Forbidden" }, status: :forbidden
  end
end