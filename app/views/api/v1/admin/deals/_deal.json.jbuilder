json.id deal.id
json.title deal.title
json.description deal.description
json.price deal.price
json.original_price deal.original_price
json.discount deal.discount
json.score deal.score
json.views deal.views
json.hot deal.hot?
json.category deal.category
json.start_date deal.start_date
json.end_date deal.end_date
json.created_at deal.created_at
json.status deal.status

json.image_url deal.images.attached? ? rails_blob_url(deal.images.first, only_path: false) : nil

json.comments_count deal.comments.size