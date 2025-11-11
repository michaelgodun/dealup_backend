class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :deal

  validates :value, inclusion: { in: [-1, 1] }
  validates :user_id, uniqueness: { scope: :deal_id, message: "already voted for this deal" }
end
