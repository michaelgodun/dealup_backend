module Dashboards
  class CommentSerializer
    include Rails.application.routes.url_helpers
    def initialize(comment)
      @comment = comment
    end

    def to_hash
      {
        id: @comment.id,
        content: @comment.content,
        user: {
          id: @comment.user_id,
          username: @comment.user.username,
          avatar_url: @comment.user.avatar.attached? ? rails_blob_url(@comment.user.avatar, only_path: false) : nil
        },
        deal_id: @comment.deal_id,
        created_at: @comment.created_at
      }
    end
  end
end