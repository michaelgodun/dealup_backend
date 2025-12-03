json.data @deals do |deal|
  json.partial! 'api/v1/admin/deals/deal', deal: deal
end

json.totals do
  json.count @deals.total_count
  json.total_count Deal.all.count
  json.total_hot Deal.hot.count
  json.total_views Deal.sum(:views)
  json.total_votes Vote.count
end

