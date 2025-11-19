json.id @deal.id
json.user do
  json.extract! @deal.user, :id, :username
end
json.title @deal.title
json.description @deal.description
json.price @deal.price
json.original_price @deal.original_price
json.discount @deal.discount
json.score @deal.score
json.views @deal.views
json.hot @deal.hot?
json.category @deal.category
json.url @deal.url
json.start_date @deal.start_date
json.end_date @deal.end_date
json.created_at @deal.created_at

json.image_url @deal.images.attached? ? rails_blob_url(@deal.images.first) : nil
json.images @deal.images do |image|
  json.id image.id
  json.url rails_blob_url(image)
end

json.comments_count @deal.comments.size
json.comments @deal.comments do |comment|
  json.id comment.id
  json.user do
    json.id comment.user.id
    json.email comment.user.email
    json.initials comment.user.initials
    json.color comment.user.color
    json.created_at comment.user.created_at
  end
  json.content comment.content
  json.created_at comment.created_at
end
