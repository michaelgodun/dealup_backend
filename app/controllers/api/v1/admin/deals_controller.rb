class Api::V1::Admin::DealsController < Api::V1::Admin::BaseController
  def index
    base_scope = Deal.where("deals.title ILIKE ?", "%#{params[:query]}%")

    @deals = Deals::SortService.new(
      base_scope,
      params[:sort_field],
      params[:sort_direction]
    ).call.page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def show
    @deal = Deal.find(params[:id])
  end

  def destroy
    deal = Deal.find(params[:id])
    deal.destroy!
    render json: { id: deal.id, message: "Deal deleted" }
  end

  def activate
    @deal = Deal.find(params[:id])
    @deal.active!
    render :show
  end

  def csv
    export = current_user.exports.create!(
      format: "csv",
      status: "pending"
    )

    GenerateDealsCsvJob.perform_later(export.id)

    render json: { export_id: export.id, status: export.status }
  end
end