class Api::V1::DealsController < Api::V1::ApiBaseController
  skip_before_action :authenticate_token, only: [:index, :show]
  before_action :set_deal, only: %i[show update destroy vote]

  def index
    @deals = Deal.all.includes(:comments, images_attachments: :blob)
  end

  def show
  end

  def update

  end

  def destroy

  end

  def vote
    vote = @deal.votes.find_or_initialize_by(user: current_user)
    vote.value = params[:value]
    if vote.save
      render json: vote
    else
      render json: { error: vote.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_deal
    @deal = Deal.find(params[:id])
  end

  def deal_params
    params.require(:deal).permit(:title, :description, :url, :price, :original_price, :category, :start_date, :end_date)
  end
end