Rails.application.config.middleware.use OmniAuth::Builder do
  configure do |config|
    config.path_prefix = "/auth"
    config.logger = Rails.logger if Rails.env.development?
  end
  provider :google_oauth2,
           Rails.application.credentials.dig(:google, :client_id),
           Rails.application.credentials.dig(:google, :client_secret),
           {
             include_granted_scopes: true,
             scope: "email, profile, offline",
           }
  OmniAuth.config.allowed_request_methods = [:get, :post]
  OmniAuth.config.silence_get_warning = true
  OmniAuth.config.on_failure = Proc.new { |env|
    OmniAuth::FailureEndpoint.new(env).redirect_to_failure
  }
end
