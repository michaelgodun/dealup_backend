# frozen_string_literal: true

module Users
  class SortService
    ALLOWED_FIELDS = %w[id username email deals comments status created_at].freeze
    ALLOWED_DIRECTIONS = %w[asc desc].freeze

    def initialize(relation, field, direction)
      @relation = relation
      @field = ALLOWED_FIELDS.include?(field) ? field : "created_at"
      @direction = ALLOWED_DIRECTIONS.include?(direction) ? direction : "desc"
    end

    def call
      case @field
      when "deals"
        order_by_deals_count
      when "comments"
        order_by_comments_count
      else
        @relation.order(@field => @direction)
      end
    end

    private

    def order_by_deals_count
      @relation
        .left_joins(:deals)
        .select("users.*, COUNT(deals.id) AS deals_count")
        .group("users.id")
        .order("deals_count #{@direction}")
    end

    def order_by_comments_count
      @relation
        .left_joins(:comments)
        .select("users.*, COUNT(comments.id) AS comments_count")
        .group("users.id")
        .order("comments_count #{@direction}")
    end

  end
end
