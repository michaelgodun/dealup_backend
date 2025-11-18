# frozen_string_literal: true

module Deals
  class SortService
    ALLOWED_FIELDS = %w[id title category price discount score comments views status created_at].freeze
    ALLOWED_DIRECTIONS = %w[asc desc].freeze

    def initialize(relation, field, direction)
      @relation = relation
      @field = ALLOWED_FIELDS.include?(field) ? field : "created_at"
      @direction = ALLOWED_DIRECTIONS.include?(direction) ? direction : "desc"
    end

    def call
      case @field
      when "comments"
        order_by_comments_count
      when "score"
        order_by_score
      when "discount"
        order_by_discount
      else
        @relation.order(@field => @direction)
      end
    end

    private

    def order_by_comments_count
      @relation
        .left_joins(:comments)
        .select("deals.*, COUNT(comments.id) AS comments_count")
        .group("deals.id")
        .order("comments_count #{@direction}")
    end

    def order_by_score
      @relation
        .left_joins(:votes)
        .select("deals.*, COALESCE(SUM(votes.value), 0) AS score_value")
        .group("deals.id")
        .order("score_value #{@direction}")
    end

    def order_by_discount
      @relation
        .select("deals.*, CEIL((original_price - price) / original_price * 100.0) AS discount_value")
        .order("discount_value #{@direction}")
    end
  end
end
