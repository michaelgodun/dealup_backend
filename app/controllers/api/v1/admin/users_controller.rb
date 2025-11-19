class Api::V1::Admin::UsersController < Api::V1::Admin::BaseController
  def index
    base_scope = User.where("users.username ILIKE ?", "%#{params[:query]}%")

    @users = Users::SortService.new(
      base_scope,
      params[:sort_field],
      params[:sort_direction]
    ).call.page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def show
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    user.destroy!
    render json: { id: user.id, message: "User deleted" }
  end

  def csv
    export = current_user.exports.create!(
      format: "csv",
      status: "pending"
    )

    GenerateUsersCsvJob.perform_later(export.id)

    render json: { export_id: export.id, status: export.status }
  end
end