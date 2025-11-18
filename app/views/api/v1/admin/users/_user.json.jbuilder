json.id user.id
json.username user.username
json.email user.email
json.status user.status
json.created_at user.created_at

json.avatar_url user.avatar.attached? ? rails_blob_url(user.avatar, only_path: false) : nil

json.deals_count user.deals.size
json.comments_count user.comments.size