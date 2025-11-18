class DealViewsJob < ApplicationJob
  queue_as :default

  def perform
    keys = $redis.keys("deal:*:views")

    keys.each do |key|
      deal_id = key.split(':')[1]
      views = $redis.get(key).to_i
      next if views.zero?

      deal = Deal.find_by(id: deal_id)
      next unless deal

      deal.increment!(:views, views)
      $redis.del(key)
    end
  end
end
