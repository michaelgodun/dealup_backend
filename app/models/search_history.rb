class SearchHistory < ApplicationRecord
  belongs_to :user

  validates :query, presence: true

  scope :recent, -> { order(updated_at: :desc) }
  scope :oldest, -> { order(updated_at: :asc) }

  MAX_HISTORY_SIZE = 5

  def self.enforce_limit!(user)
    oldest_records = user.search_histories.oldest

    count = oldest_records.count
    if count > MAX_HISTORY_SIZE
      records_to_delete_count = count - MAX_HISTORY_SIZE
      records_to_delete_ids = oldest_records.limit(records_to_delete_count).pluck(:id)

      SearchHistory.destroy(records_to_delete_ids)
    end
  end
end