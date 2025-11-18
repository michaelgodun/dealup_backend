class Api::V1::Admin::CommentsController < Api::V1::Admin::BaseController
  def index
    comments = Comment.all
    render json: comments
  end

  def show
    comment = Comment.find(params[:id])
    render json: comment
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy!
    render json: { message: "Comment deleted" }
  end
end