class Deal < ApplicationRecord
  CATEGORIES = %w[Electronics Gaming Accessories Computers Audio Home Fashion Sports Books Toys Fitness].freeze

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :votes, dependent: :destroy

  has_many_attached :images

  validates :title, :description, :price, presence: true
  validates :category, inclusion: { in: CATEGORIES, message: "%{value} is not a valid category" }
  validate :url_validation

  scope :hot, -> {
    where("(SELECT COALESCE(SUM(value), 0) FROM votes WHERE votes.deal_id = deals.id) > 3")
  }

  enum :status, {
    draft: 0,
    active: 1,
    expired: 2,
    archived: 3
  }, default: 0

  def discount
    return nil unless original_price.present? && price.present? && original_price > 0

    ((original_price - price) / original_price * 100).ceil
  end

  def score
    votes.sum(:value)
  end

  def hot?
    score > 3
  end

  def self.search(search_query)
    sanitized_query = "%#{search_query.to_s.strip.downcase}%"

    where('title ILIKE ? OR description ILIKE ? OR category ILIKE ?', sanitized_query, sanitized_query, sanitized_query)
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
