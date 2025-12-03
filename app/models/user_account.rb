class UserAccount < ApplicationRecord
  belongs_to :user

  validates :provider_account_id, presence: true, uniqueness: { scope: :provider }
  validates :provider, presence: true

  def self.find_or_create_from_omniauth(auth)
    user_account = find_or_initialize_by(
      provider: auth.provider,
      provider_account_id: auth.uid
    )
    user = User.find_by(email: auth.info.email)

    if user.nil?
      generated_password = SecureRandom.hex(10)
      user = User.create!(
        email: auth.info.email,
        username: "#{auth.info.name.parameterize.underscore}_#{SecureRandom.hex(4)}",
        password: generated_password,
        password_confirmation: generated_password,
      )
    end
    user_account.attributes = {
      access_token: auth.credentials.token,
      auth_protocol: "oauth2",
      expires_at: Time.at(auth.credentials.expires_at).to_datetime,
      refresh_token: auth.credentials.refresh_token,
      scope: auth.credentials.scope,
      token_type: "Bearer",
      user: user
    }
    user_account.save!

    user_account.user
  end
end