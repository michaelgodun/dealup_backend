module Dashboards
  class StatsSerializer
    def initialize(stats:, recent:)
      @stats = stats
      @recent = recent
    end

    def to_hash
      {
        stats: @stats,
        recent: {
          newest_deals: serialize_deals(@recent[:newest_deals]),
          newest_comments: serialize_comments(@recent[:newest_comments])
        }
      }
    end

    private

    def serialize_deals(deals)
      deals.map { |d| DealSerializer.new(d).to_hash }
    end

    def serialize_comments(comments)
      comments.map { |c| CommentSerializer.new(c).to_hash }
    end
  end
end
