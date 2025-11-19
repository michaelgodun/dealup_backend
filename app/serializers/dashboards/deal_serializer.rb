module Dashboards
  class DealSerializer
    include Rails.application.routes.url_helpers
    def initialize(deal)
      @deal = deal
    end

    def to_hash
      {
        id: @deal.id,
        image_url: @deal.images.attached? ? rails_blob_url(@deal.images.first, only_path: false) : nil,
        title: @deal.title,
        description: @deal.description,
        category: @deal.category,
        price: @deal.price,
        discount: @deal.discount,
        created_at: @deal.created_at
      }
    end
  end
end
