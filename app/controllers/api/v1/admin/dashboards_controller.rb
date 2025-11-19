class Api::V1::Admin::DashboardsController < Api::V1::Admin::BaseController
  def index
    period = params[:period]&.to_sym || :this_week
    data = Dashboard::StatsService.new(period).call

    render json: Dashboards::StatsSerializer.new(
      stats: data[:stats],
      recent: data[:recent]
    ).to_hash
  end

end