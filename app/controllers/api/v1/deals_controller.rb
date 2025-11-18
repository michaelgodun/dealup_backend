class Api::V1::DealsController < Api::V1::ApiBaseController
  skip_before_action :authenticate_token, only: [:index, :show]
  load_and_authorize_resource
  def index
    @deals = @deals.active.includes(:comments).order(created_at: :desc).page(params[:page] || 1).per(params[:per_page] || 10)
  end

  def show
    redis_key = "deal:#{@deal.id}:views"
    $redis.incr(redis_key)
  end

  def create
    @deal.user = current_user
    if @deal.save
      render json: @deal, status: :created
    else
      render json: { errors: @deal.errors.full_messages }, status: :unprocessable_entity
    end
  end


  def update
    images_meta = JSON.parse(params.dig(:deal, :images_meta) || "[]")
    new_files = params.dig(:deal, :images) || []

    images_meta.each do |img|
      next unless img["_deleted"]

      image = @deal.images.find_by(id: img["id"])
      image&.purge
    end

    new_files.each { |file| @deal.images.attach(file) }

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
      render json: { errors: vote.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def deal_params
    params.require(:deal).permit(
      :title, :description, :url, :price, :original_price, :category, :start_date, :end_date,
      images: [], images_meta: []
    )
  end
end