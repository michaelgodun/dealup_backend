class Deal < ApplicationRecord
  CATEGORIES = [
    'Electronics', 'Sports', 'Fashion', 'Books', 'Home',
    'Gaming', 'Health & Beauty', 'Automotive', 'Food & Drinks', 'Other'
  ].freeze

  belongs_to :user
  has_many :comments
  has_many :votes, dependent: :destroy

  has_many_attached :images

  validates :title, :description, :price, presence: true
  validates :category, inclusion: { in: CATEGORIES, message: "%{value} is not a valid category" }
  validate :url_validation

  def discount
    return nil unless original_price.present? && price.present? && original_price > 0

    ((original_price - price) / original_price * 100).ceil
  end

  def score
    votes.sum(:value)
  end
  def hot?
    positive_votes - negative_votes >= 100
  end

  private

  def url_validation
    return if url.blank?

    uri = URI.parse(url) rescue nil
    unless uri.is_a?(URI::HTTP) || uri.is_a?(URI::HTTPS)
      errors.add(:url, "must be a valid HTTP or HTTPS URL")
    end
  end
end
