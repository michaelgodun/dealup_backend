json.data @users do |user|
  json.partial! 'api/v1/admin/users/user', user: user
end

json.totals do
  json.total_count @users.total_count
  json.total_new User.recent.count
  json.total_active User.active.count
  json.total_inactive User.inactive.count
end

