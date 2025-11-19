Sidekiq.configure_server do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0' } }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV.fetch('REDIS_URL') { 'redis://localhost:6379/0' } }
end

# Authentication middleware for Sidekiq::Web in Rails API-only
# This is needed because Devise doesn't use sessions by default in API-only apps
require 'sidekiq/web'
require 'rack/auth/basic'

# Use HTTP Basic Authentication for Sidekiq::Web
# In development, you can use any admin user's email and password
# In production, consider using environment variables for credentials
Sidekiq::Web.use Rack::Auth::Basic, "Protected Area" do |username, password|
  user = User.find_by(email: username)
  user&.valid_password?(password) && user.admin?
end

require 'sidekiq'
require 'sidekiq-cron'

Sidekiq::Cron::Job.create(
  name: 'Deal Views Job - every minute',
  cron: '*/1 * * * *',
  class: 'DealViewsJob'
)
Sidekiq::Cron::Job.create(
  name: 'Refresh Dashboard Cache Job - every minute',
  cron: '*/1 * * * *',
  class: 'RefreshDashboardCacheJob'
)