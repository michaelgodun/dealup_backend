class Api::V1::SearchHistoriesController < Api::V1::ApiBaseController
  skip_before_action :authenticate_token, only: [:index]
  before_action :optionally_authenticate_token, only: [:index]
  load_and_authorize_resource

  def index
    if current_user
      recent_searches = current_user.search_histories
                                    .recent
                                    .limit(5).select(:id, :query)
    end

    popular_categories = PopularCategoriesService.new(limit: 3, days_back: 30).call

    render json: {
      recent_searches: recent_searches,
      popular_categories: popular_categories
    }
  end

  def create
    query_param = search_history_params[:query]

    return render json: { errors: ["Query cannot be blank"] }, status: :unprocessable_entity if query_param.blank?

    @search_history = current_user.search_histories.find_or_initialize_by(query: query_param)

    if @search_history.new_record?
      if @search_history.save
        status = :created
      else
        return render json: { errors: @search_history.errors.full_messages }, status: :unprocessable_entity
      end
    else
      @search_history.touch
      status = :ok
    end

    SearchHistory.enforce_limit!(current_user)

    render json: @search_history, status: status
  end

  def destroy
    @search_history.destroy
    head :no_content
  end

  private

  def search_history_params
    params.require(:search_history).permit(:query)
  end
end