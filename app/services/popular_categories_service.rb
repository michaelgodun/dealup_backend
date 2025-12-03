class PopularCategoriesService
  CATEGORIES = %w[Electronics Gaming Accessories Computers Audio Home Fashion Sports Books Toys Fitness].freeze

  def initialize(limit: 3, days_back: 30)
    @limit = limit
    @days_back = days_back
  end

  def call
    active_deals_by_category
      .sort_by { |_, count| -count }
      .first(@limit)
      .map { |category, count| { name: category, count: count } }
  end

  private

  def active_deals_by_category
    Deal.active
      .where('created_at > ?', @days_back.days.ago)
      .group(:category)
      .count
  end
end