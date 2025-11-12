class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :votes, dependent: :destroy

  validates :username, presence: true, uniqueness: true

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
