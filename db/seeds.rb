# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


# db/seeds.rb

User.delete_all


user1 = User.create!(
  email_address: 'barrett@gmail.com',
  password: 'password123', # Use a plain password for seeding
  name: 'Test User'
)

if user1.persisted?
  puts "User created successfully!"
else
  puts "Failed to create user: #{user1.errors.full_messages.join(', ')}"
end

user2 = User.create!(
  email_address: 'bailyolivas8@gmail.com',
  password: 'baily', # Use a plain password for seeding
  name: 'Baily Olivas'
)

if user2.persisted?
  puts "User created successfully!"
else
  puts "Failed to create user: #{user2.errors.full_messages.join(', ')}"
end
