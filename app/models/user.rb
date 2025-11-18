class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one_attached :avatar
  has_many :deals, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy
  has_many :exports, dependent: :destroy
  validates :username, presence: true, uniqueness: true

  enum :status, { active: 0, inactive: 1, banned: 2, pending: 3 }
  scope :recent, -> { where(created_at: 7.days.ago..) }

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
