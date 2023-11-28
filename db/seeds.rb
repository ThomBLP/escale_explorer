# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[Review, Place, Visit, Journey, User].each { |model| model.destroy_all }

10.times do
  Category.create!(name: Faker::GreekPhilosophers.name)
end

puts "catégories creées."

100.times do
  place = Place.new
  place.name = Faker::Company.name
  place.description = Faker::Lorem.sentence
  place.address = Faker::Address.full_address
  place.visit_duration = rand(60..180)
  place.lat = rand(45.73..45.78)
  place.long = rand(4.82..4.87)
  place.category_id = Category.pluck(:id).sample
  place.save
end

puts "Lieux créés."


User.create!({nickname: "Vincent", email: "toto+1@free.fr", password: "azerty"})
User.create!({nickname: "Thomas", email: "toto+2@free.fr", password: "azerty"})
User.create!({nickname: "Carine", email: "toto+3@free.fr", password: "azerty"})
User.create!({nickname: "Corentin", email: "toto+4@free.fr", password: "azerty"})
puts "Utilisateurs créés."
