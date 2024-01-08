# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create Users
users = []
5.times do |i|
  users << User.create(name: "User #{i + 1}")
end

# Create Groups
groups = []
3.times do |i|
  groups << Group.create(name: "Group #{i + 1}", user: users.sample)
end

# Create Entities
entities = []
5.times do |i|
  entities << Entity.create(name: "Entity #{i + 1}", amount: rand(1..1000), user: users.sample)
end

# Create GroupEntities
10.times do
  group_entity = GroupEntity.create(group: groups.sample, entity: entities.sample)
end

puts "Seed data created successfully!"
