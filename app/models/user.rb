class User < ApplicationRecord
  has_secure_password

  has_one_attached :avatar
  has_many :deals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :exports, dependent: :destroy
  has_many :user_accounts, dependent: :destroy
  has_many :search_histories, dependent: :destroy

  validates :email,
            presence: true,
            uniqueness: { case_sensitive: false },
            format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid format" }

  validate :prevent_email_change_with_linked_accounts, on: :update

  validates :password,
            length: { minimum: 8, message: "must be at least 8 characters long" },
            presence: true,
            allow_nil: true,
            on: :update
  validates :password, presence: true, on: :create
  validates :username,
            presence: true,
            uniqueness: { case_sensitive: false },
            length: { minimum: 3, maximum: 50 },
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "can only contain letters, numbers, and underscores" }
  validates :refresh_token, uniqueness: { allow_nil: true }

  enum :status, { active: 0, inactive: 1, banned: 2, pending: 3 }
  scope :recent, -> { where(created_at: 7.days.ago..) }


  def has_linked_accounts?
    user_accounts.exists?
  end

  def prevent_email_change_with_linked_accounts
    p "walidacja #{email_changed?}, #{has_linked_accounts?}"
    if email_changed? && has_linked_accounts?
      errors.add(:email, "cannot be changed when linked to external accounts")
    end
  end

  def initials
    letters = ('A'..'Z').to_a
    "#{letters.sample}#{letters.sample}"
  end

  def color
    base_colors = %w[red blue green yellow purple pink indigo teal orange cyan]
    base_colors.sample
  end

  def admin?
    admin
  end
end
