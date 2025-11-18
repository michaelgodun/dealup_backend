json.data @deals do |deal|
  json.partial! 'api/v1/admin/deals/deal', deal: deal
end

json.totals do
  json.total_count @deals.total_count
  json.total_hot Deal.hot.count
  json.total_views Deal.sum(:views)
  json.total_votes Vote.count
end

