class Api::V1::VotesController < Api::V1::ApiBaseController
  before_action :set_deal

  def create
    vote = @deal.votes.find_or_initialize_by(user: current_user)
    vote.value = params[:value].to_i
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

end