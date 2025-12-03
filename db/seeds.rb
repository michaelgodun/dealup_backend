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
                       username: 'michal',
                       email: 'admin@example.com',
                       password: 'password',
                       password_confirmation: 'password',
                       admin: true
                     })

user = User.create!({
                      username: 'user',
                      email: 'user@example.com',
                      password: 'password',
                      password_confirmation: 'password',
                    })

user1 = User.create!({
                       username: 'user1',
                       email: 'user1@example.com',
                       password: 'password',
                       password_confirmation: 'password',
                     })
user2 = User.create!({
                       username: 'user2',
                       email: 'user2@example.com',
                       password: 'password',
                       password_confirmation: 'password',
                     })
user3 = User.create!({
                       username: 'user3',
                       email: 'user3@example.com',
                       password: 'password',
                       password_confirmation: 'password',
                     })
user4 = User.create!({
                       username: 'user4',
                       email: 'user4@example.com',
                       password: 'password',
                       password_confirmation: 'password',
                     })
user5 = User.create!({
                       username: 'user5',
                       email: 'user5@example.com',
                       password: 'password',
                       password_confirmation: 'password',
                     })

users = [ user, user1, user2, user3, user4, user5 ]

def random_past_time(days_back = 30)
  rand(days_back).days.ago
end

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
  user: users.sample,
  title: "iPhone 15 Pro 256GB - Amazing Deal!",
  description: "Latest iPhone at a great price. All colors available. 24-month warranty.",
  price: 4199.00,
  original_price: 5499.00,
  views: 12453,
  category: "Electronics"
)
attach_image(deal1, "https://images.unsplash.com/photo-1695639509828-d4260075e370?w=400&h=300&fit=crop", "iphone15.jpg")

deal2 = Deal.create!(
  user: users.sample,
  title: "PlayStation 5 + 2 Games Bundle",
  description: "PS5 console with two hit games. Official distributor. Immediate shipping.",
  price: 2399.00,
  original_price: 2899.00,
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
  views: 6421,
  category: "Electronics"
)
attach_image(deal3, "https://images.unsplash.com/photo-1579586337278-3befd40fd17a?w=400&h=300&fit=crop", "galaxy_watch6.jpg")

deal4 = Deal.create!(
  user: users.sample,
  title: "MacBook Air M2 - Lowest Price Ever",
  description: "Apple ultrabook with M2 processor. 8GB RAM, 256GB SSD. Perfect for work and entertainment.",
  price: 4899.00,
  original_price: 5999.00,
  views: 15678,
  category: "Electronics",
  created_at: random_past_time
)
attach_image(deal4, "https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400&h=300&fit=crop", "macbook_air_m2.jpg")

deal5 = Deal.create!(
  user: users.sample,
  title: "Sony WH-1000XM5 - Headphones with ANC",
  description: "Best headphones with active noise cancellation. Highest level of wearing comfort.",
  price: 1199.00,
  original_price: 1599.00,
  views: 9234,
  category: "Electronics",
  created_at: random_past_time
)
attach_image(deal5, "https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=400&h=300&fit=crop", "sony_wh1000xm5.jpg")

deal6 = Deal.create!(
  user: users.sample,
  title: "Dyson V15 Detect - Cordless Vacuum",
  description: "Powerful vacuum with laser detection. Battery up to 60 minutes. HEPA filter.",
  price: 2299.00,
  original_price: 2999.00,
  views: 5821,
  category: "Home",
  created_at: random_past_time
)
attach_image(deal6, "https://images.unsplash.com/photo-1558317374-067fb5f30001?w=400&h=300&fit=crop", "dyson_v15.jpg")

# Electronics
deal7 = Deal.create!(
  user: users.sample,
  title: "Sony WH-1000XM4 Wireless Headphones",
  description: "Industry-leading noise cancellation. 30-hour battery life. Touch controls.",
  price: 279.99,
  original_price: 349.99,
  views: 4237,
  category: "Electronics",
  created_at: random_past_time
)
attach_image(deal7, "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop", "sony_headphones.jpg")

# Gaming
deal8 = Deal.create!(
  user: users.sample,
  title: "PlayStation 5 Digital Edition",
  description: "Next-gen gaming console. 825GB SSD. 4K gaming and entertainment.",
  price: 399.99,
  original_price: 499.99,
  views: 8923,
  category: "Gaming",
  created_at: random_past_time
)
attach_image(deal8, "https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400&h=300&fit=crop", "ps5_digital.jpg")

# Computers
deal9 = Deal.create!(
  user: users.sample,
  title: "MacBook Air M2 13-inch",
  description: "Apple M2 chip. 8GB RAM, 256GB SSD. Retina display. All-day battery.",
  price: 999.00,
  original_price: 1199.00,
  views: 6542,
  category: "Computers",
  created_at: random_past_time
)
attach_image(deal9, "https://images.unsplash.com/photo-1541807084-5c52b6b3adef?w=400&h=300&fit=crop", "macbook_air.jpg")

# Home
deal10 = Deal.create!(
  user: users.sample,
  title: "Ninja Foodi 8-in-1 Digital Air Fryer",
  description: "Pressure cooker and air fryer combo. 6.5QT capacity. Digital controls.",
  price: 149.99,
  original_price: 199.99,
  views: 3128,
  category: "Home",
  created_at: random_past_time
)
attach_image(deal10, "https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=400&h=300&fit=crop", "ninja_foodi.jpg")

# Fitness
deal11 = Deal.create!(
  user: users.sample,
  title: "Peloton Bike Basic Package",
  description: "Connected fitness bike with 22\" touchscreen. Live and on-demand classes.",
  price: 1445.00,
  original_price: 1745.00,
  views: 2876,
  category: "Fitness",
  created_at: random_past_time
)
attach_image(deal11, "https://images.unsplash.com/photo-1571019613454-1cb2f99b2d8b?w=400&h=300&fit=crop", "peloton_bike.jpg")

# Audio
deal12 = Deal.create!(
  user: users.sample,
  title: "Sonos Beam Soundbar - Gen 2",
  description: "Compact smart soundbar with Dolby Atmos. Voice control compatible.",
  price: 399.00,
  original_price: 499.00,
  views: 1987,
  category: "Audio",
  created_at: random_past_time
)
attach_image(deal12, "https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=400&h=300&fit=crop", "sonos_beam.jpg")

# Fashion
deal13 = Deal.create!(
  user: users.sample,
  title: "Nike Air Force 1 '07 SE",
  description: "Classic white leather sneakers. Comfortable cushioning. Timeless design.",
  price: 89.99,
  original_price: 119.99,
  views: 5421,
  category: "Fashion",
  created_at: random_past_time
)
attach_image(deal13, "https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=400&h=300&fit=crop", "nike_af1.jpg")

# Sports
deal14 = Deal.create!(
  user: admin,
  title: "Yeti Tundra 45 Cooler",
  description: "Rotomolded construction. Bear-proof design. Keeps ice for days.",
  price: 274.99,
  original_price: 324.99,
  views: 1654,
  category: "Sports",
  created_at: random_past_time
)
attach_image(deal14, "https://images.unsplash.com/photo-1578662996442-48f60103fc96?w=400&h=300&fit=crop", "yeti_cooler.jpg")

# Electronics
deal15 = Deal.create!(
  user: users.sample,
  title: "iPad Air 5th Generation",
  description: "M1 chip. 10.9-inch Liquid Retina display. 5G capable. Stunning performance.",
  price: 549.00,
  original_price: 699.00,
  views: 3876,
  category: "Electronics",
  created_at: random_past_time
)
attach_image(deal15, "https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400&h=300&fit=crop", "ipad_air.jpg")

# Home
deal16 = Deal.create!(
  user: users.sample,
  title: "Roomba j7+ Self-Emptying Robot Vacuum",
  description: "Avoids cords and pet waste. Self-emptying base. Smart mapping.",
  price: 599.00,
  original_price: 799.00,
  views: 2987,
  category: "Home",
  created_at: random_past_time
)
# Option 1: Different robot vacuum image
attach_image(deal16, "https://images.unsplash.com/photo-1581094794329-c8112a89af12?w=400&h=300&fit=crop", "roomba_j7.jpg")

deal17 = Deal.create!(
  user: users.sample,
  title: "PlayStation 5 + 2 Games Bundle",
  description: "PS5 console with two hit games. Official distributor. Immediate shipping.",
  price: 2399.00,
  original_price: 2899.00,
  views: 8932,
  category: "Gaming",
  created_at: random_past_time
)
attach_image(deal17, "https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=400&h=300&fit=crop", "ps5.jpg")

deal18 = Deal.create!(
  user: users.sample,
  title: "BOSE QuietComfort 45 Wireless Headphones",
  description: "Noise cancelling headphones with crystal-clear sound. 1 year warranty.",
  price: 999.00,
  original_price: 1299.00,
  views: 7520,
  category: "Audio",
  created_at: random_past_time
)
attach_image(deal18, "https://images.unsplash.com/photo-1512314889357-e157c22f938d?w=400&h=300&fit=crop", "boseqc45.jpg")
# Comments
Comment.create!(deal: deal1, user: user, content: "Amazing deal, just bought mine!", created_at: random_past_time)
Comment.create!(deal: deal1, user: admin, content: "Thanks for shopping with us!", created_at: random_past_time)
Comment.create!(deal: deal2, user: user, content: "Bundle looks great, excited to get it.", created_at: random_past_time)
Comment.create!(deal: deal4, user: admin, content: "MacBook M2 is on fire, highly recommended!", created_at: random_past_time)
# Comments for deal6 (Dyson V15)
Comment.create!(deal: deal6, user: user, content: "The laser detection is a game changer for pet hair!", created_at: random_past_time)
Comment.create!(deal: deal6, user: admin, content: "One of our best-selling vacuums this season!", created_at: random_past_time)
Comment.create!(deal: deal6, user: user, content: "Battery life is incredible, worth every penny.", created_at: random_past_time)

# Comments for deal7 (Sony Headphones)
Comment.create!(deal: deal7, user: user, content: "Noise cancellation is mind-blowing on these!", created_at: random_past_time)
Comment.create!(deal: deal7, user: admin, content: "Perfect for travel and daily commutes.", created_at: random_past_time)
Comment.create!(deal: deal7, user: user, content: "Comfortable for all-day wear, highly recommend.", created_at: random_past_time)

# Comments for deal8 (PS5 Digital)
Comment.create!(deal: deal8, user: user, content: "Finally got one! The load times are insane!", created_at: random_past_time)
Comment.create!(deal: deal8, user: admin, content: "Limited stock available at this price!", created_at: random_past_time)
Comment.create!(deal: deal8, user: user, content: "Digital edition is perfect for my all-digital library.", created_at: random_past_time)

# Comments for deal9 (MacBook Air)
Comment.create!(deal: deal9, user: user, content: "M2 chip is ridiculously fast for photo editing.", created_at: random_past_time)
Comment.create!(deal: deal9, user: admin, content: "Students get an additional $50 off with EDU discount!", created_at: random_past_time)
Comment.create!(deal: deal9, user: user, content: "Battery lasts through my entire work day, love it!", created_at: random_past_time)

# Comments for deal10 (Ninja Foodi)
Comment.create!(deal: deal10, user: user, content: "This replaced 3 appliances in my kitchen!", created_at: random_past_time)
Comment.create!(deal: deal10, user: admin, content: "Great for healthy air-fried meals!", created_at: random_past_time)

Deal.all.each do |deal|
  users.each do |user|
    Vote.create!(deal: deal, user: user, value: [ -1, 1 ].sample,created_at: random_past_time)
  end
end

# Comments for deal1
Comment.create!(deal: deal1, user: users.sample, content: "Amazing deal, just bought mine!", created_at: random_past_time)
Comment.create!(deal: deal1, user: admin, content: "Thanks for shopping with us!", created_at: random_past_time)

# Comments for deal2
Comment.create!(deal: deal2, user: users.sample, content: "Bundle looks great, excited to get it.", created_at: random_past_time)

# Comments for deal4
Comment.create!(deal: deal4, user: admin, content: "MacBook M2 is on fire, highly recommended!", created_at: random_past_time)

# Comments for deal6 (Dyson V15)
Comment.create!(deal: deal6, user: users.sample, content: "The laser detection is a game changer for pet hair!", created_at: random_past_time)
Comment.create!(deal: deal6, user: admin, content: "One of our best-selling vacuums this season!", created_at: random_past_time)
Comment.create!(deal: deal6, user: users.sample, content: "Battery life is incredible, worth every penny.", created_at: random_past_time)

# Comments for deal7 (Sony Headphones)
Comment.create!(deal: deal7, user: users.sample, content: "Noise cancellation is mind-blowing on these!", created_at: random_past_time)
Comment.create!(deal: deal7, user: admin, content: "Perfect for travel and daily commutes.", created_at: random_past_time)
Comment.create!(deal: deal7, user: users.sample, content: "Comfortable for all-day wear, highly recommend.", created_at: random_past_time)

# Comments for deal8 (PS5 Digital)
Comment.create!(deal: deal8, user: users.sample, content: "Finally got one! The load times are insane!", created_at: random_past_time)
Comment.create!(deal: deal8, user: admin, content: "Limited stock available at this price!", created_at: random_past_time)
Comment.create!(deal: deal8, user: users.sample, content: "Digital edition is perfect for my all-digital library.", created_at: random_past_time)

# Comments for deal9 (MacBook Air)
Comment.create!(deal: deal9, user: users.sample, content: "M2 chip is ridiculously fast for photo editing.", created_at: random_past_time)
Comment.create!(deal: deal9, user: admin, content: "Students get an additional $50 off with EDU discount!", created_at: random_past_time)
Comment.create!(deal: deal9, user: users.sample, content: "Battery lasts through my entire work day, love it!", created_at: random_past_time)

# Comments for deal10 (Ninja Foodi)
Comment.create!(deal: deal10, user: users.sample, content: "This replaced 3 appliances in my kitchen!", created_at: random_past_time)
Comment.create!(deal: deal10, user: admin, content: "Great for healthy air-fried meals!", created_at: random_past_time)