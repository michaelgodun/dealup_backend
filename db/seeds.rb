# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require "open-uri"

# Users
admin = User.create!({
                       email: 'admin@example.com',
                       password: 'password'
                     })

user = User.create!({
                      email: 'user@example.com',
                      password: 'password'
                    })

# Helper do dodawania obrazów z URL
def attach_image(record, url, filename)
  begin
    file = URI.open(url)
    record.images.attach(io: file, filename: filename)
  rescue OpenURI::HTTPError => e
    puts "WARNING: Cannot attach image from #{url} - #{e.message}"
  end
end

# Deals
deal1 = Deal.create!(
  user: admin,
  title: "iPhone 15 Pro 256GB - Amazing Deal!",
  description: "Latest iPhone at a great price. All colors available. 24-month warranty.",
  price: 4199.00,
  original_price: 5499.00,
  positive_votes: 342,
  negative_votes: 0,
  views: 12453,
  category: "Electronics"
)
attach_image(deal1, "https://images.unsplash.com/photo-1695639509828-d4260075e370?w=400&h=300&fit=crop", "iphone15.jpg")

deal2 = Deal.create!(
  user: admin,
  title: "PlayStation 5 + 2 Games Bundle",
  description: "PS5 console with two hit games. Official distributor. Immediate shipping.",
  price: 2399.00,
  original_price: 2899.00,
  positive_votes: 256,
  negative_votes: 0,
  views: 8932,
  category: "Gaming"
)
attach_image(deal2, "https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400&h=300&fit=crop", "ps5.jpg")

deal3 = Deal.create!(
  user: user,
  title: "Samsung Galaxy Watch 6 - Promotion",
  description: "Smartwatch with advanced health features. IP68 water resistance.",
  price: 899.00,
  original_price: 1299.00,
  positive_votes: 189,
  negative_votes: 0,
  views: 6421,
  category: "Electronics"
)
attach_image(deal3, "https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400&h=300&fit=crop", "galaxy_watch6.jpg")

deal4 = Deal.create!(
  user: user,
  title: "MacBook Air M2 - Lowest Price Ever",
  description: "Apple ultrabook with M2 processor. 8GB RAM, 256GB SSD. Perfect for work and entertainment.",
  price: 4899.00,
  original_price: 5999.00,
  positive_votes: 412,
  negative_votes: 0,
  views: 15678,
  category: "Electronics"
)
attach_image(deal4, "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=300&fit=crop", "macbook_air_m2.jpg")

deal5 = Deal.create!(
  user: admin,
  title: "Sony WH-1000XM5 - Headphones with ANC",
  description: "Best headphones with active noise cancellation. Highest level of wearing comfort.",
  price: 1199.00,
  original_price: 1599.00,
  positive_votes: 278,
  negative_votes: 0,
  views: 9234,
  category: "Electronics"
)
attach_image(deal5, "https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400&h=300&fit=crop", "sony_wh1000xm5.jpg")

deal6 = Deal.create!(
  user: admin,
  title: "Dyson V15 Detect - Cordless Vacuum",
  description: "Powerful vacuum with laser detection. Battery up to 60 minutes. HEPA filter.",
  price: 2299.00,
  original_price: 2999.00,
  positive_votes: 156,
  negative_votes: 0,
  views: 5821,
  category: "Home"
)
attach_image(deal6, "https://images.unsplash.com/photo-1558317374-067fb5f30001?w=400&h=300&fit=crop", "dyson_v15.jpg")

# Comments
Comment.create!(deal: deal1, user: user, content: "Amazing deal, just bought mine!")
Comment.create!(deal: deal1, user: admin, content: "Thanks for shopping with us!")
Comment.create!(deal: deal2, user: user, content: "Bundle looks great, excited to get it.")
Comment.create!(deal: deal4, user: admin, content: "MacBook M2 is on fire, highly recommended!")

