class Auth::OmniauthCallbacksController < ApplicationController
  def passthru
    head :not_found
  end

  def google
    auth = request.env['omniauth.auth']

    user = UserAccount.find_or_create_from_omniauth(auth)

    if user.persisted?
      access_token = JsonWebToken.encode({ sub: user.id }, 5.minutes.from_now.to_i, user.admin)
      refresh_token = JsonWebToken.encode({ sub: user.id }, 7.days.from_now)
      user.update!(refresh_token: refresh_token)

      redirect_to "#{Rails.configuration.frontend_url}/auth/callback?access_token=#{access_token}&refresh_token=#{refresh_token}",
                  allow_other_host: true
    else
      redirect_to "#{Rails.configuration.frontend_url}/login?error=auth_failed",
                  allow_other_host: true
    end
  rescue StandardError => e
    redirect_to "#{Rails.configuration.frontend_url}/login?error=server_error&message=#{e.message}",
                allow_other_host: true
  end

  def failure
    p 'dupa'
    Rails.logger.error("OmniAuth failure: #{params.inspect}")
    redirect_to "#{Rails.configuration.frontend_url}/login?error=access_denied",
                allow_other_host: true
  end
end
