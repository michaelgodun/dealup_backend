module Dashboard
  class StatsService
    TTL_STATS = 1.minute
    TTL_RECENT = 10.seconds

    PERIODS = {
      this_week: -> { Time.current.beginning_of_week..Time.current },
      this_month: -> { Time.current.beginning_of_month..Time.current },
      this_year: -> { Time.current.beginning_of_year..Time.current }
    }.freeze

    PREVIOUS_PERIODS = {
      this_week: -> { 1.week.ago.beginning_of_week..1.week.ago.end_of_week },
      this_month: -> { 1.month.ago.beginning_of_month..1.month.ago.end_of_month },
      this_year: -> { 1.year.ago.beginning_of_year..1.year.ago.end_of_year }
    }.freeze

    def initialize(period = :this_week)
      @period = period
    end

    def call
      {
        stats: cached_stats,
        recent: cached_recent
      }
    end

    private

    # -------------------------
    # CACHE
    # -------------------------
    def cached_stats
      Rails.cache.fetch(stats_cache_key, expires_in: TTL_STATS) do
        calculate_stats
      end
    end

    def cached_recent
      Rails.cache.fetch(recent_cache_key, expires_in: TTL_RECENT) do
        recent_items
      end
    end

    # -------------------------
    # STATS
    # -------------------------
    def calculate_stats
      current = stats_for(period_range)
      previous = stats_for(previous_period_range)

      current.transform_values.with_index do |value, index|
        prev = previous.values[index] || 0

        {
          value: value,
          change_percent: percent_change(prev, value)
        }
      end
    end

    def stats_for(range)
      deals = Deal.where(created_at: range)
      comments = Comment.where(created_at: range)
      votes = Vote.where(created_at: range)

      {
        created_deals: deals.count,
        hot_deals: deals.hot.count,
        comments: comments.count,
        votes: votes.count
      }
    end

    # -------------------------
    # RECENT ITEMS (RAW RECORDS)
    # -------------------------
    def recent_items
      {
        newest_deals: Deal.order(created_at: :desc).limit(3),
        newest_comments: Comment.order(created_at: :desc).limit(3)
      }
    end

    # -------------------------
    # HELPERS
    # -------------------------
    def period_range
      PERIODS[@period].call
    end

    def previous_period_range
      PREVIOUS_PERIODS[@period].call
    end

    def percent_change(previous, current)
      return 0 if previous.zero?
      ((current - previous) * 100.0 / previous).round(2)
    end

    def stats_cache_key
      "dashboard:stats:#{@period}"
    end

    def recent_cache_key
      "dashboard:recent"
    end
  end
end
