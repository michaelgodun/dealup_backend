class Export < ApplicationRecord
  belongs_to :user
  has_one_attached :file

  enum :status, {
    pending: "pending",
    processing: "processing",
    finished: "finished",
    failed: "failed"
  }, default: "pending"
end
