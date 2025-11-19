class RefreshDashboardCacheJob < ApplicationJob
  queue_as :default

  def perform
    [:this_week, :this_month, :this_year].each do |period|
      Dashboard::StatsService.new(period).call
    end
  end
end
