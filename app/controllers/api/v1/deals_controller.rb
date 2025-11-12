class Api::V1::DealsController < Api::V1::ApiBaseController
  skip_before_action :authenticate_token, only: [:index, :show]
  before_action :set_deal, only: %i[show update destroy vote]

  def index
    @deals = Deal.all.includes(:comments, images_attachments: :blob).order(created_at: :desc)
  end

  def show
  end

  def create
    @deal = Deal.new(deal_params)
    @deal.user_id = current_user.id
    if @deal.save
      render status: :created
    else
      render json: { errors: @deal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @deal.user_id = current_user.id
    images_meta = JSON.parse(params.dig(:deal, :images_meta) || "[]")
    new_files = params.dig(:deal, :images) || []

    images_meta.each do |img|
      next unless img["_deleted"]

      image = @deal.images.find_by(id: img["id"])
      image&.purge
    end

    new_files.each do |file|
      @deal.images.attach(file)
    end

    if @deal.update(deal_params.except(:images, :images_meta))
      render json: @deal
    else
      render json: { errors: @deal.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @deal.destroy
    head :no_content
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
    params.require(:deal).permit(
      :title, :description, :url, :price, :original_price, :category, :start_date, :end_date,
      images: [], images_meta: []
    )
  end
end