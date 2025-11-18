json.username @user.username
json.email @user.email
json.avatar @user.avatar.attached? ? { id: @user.avatar.id, url: rails_blob_url(@user.avatar) } : nil
json.deals_count @user.deals.count
json.comments_count @user.comments.count