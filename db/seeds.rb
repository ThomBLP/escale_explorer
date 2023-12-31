# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require "csv"

[Place, Journey, Category, Visit, Review, User].each { |model| model.destroy_all }

Category.create!({name: "spectacles"})
Category.create!({name: "patrimoine"})
Category.create!({name: "restaurants"})
Category.create!({name: "loisirs"})
Category.create!({name: "bars"})
Category.create!({name: "musees"})
puts "categories créées."


filepath = "db/seed284.csv"
CSV.foreach(filepath, headers: :first_row, col_sep: ";") do |row|
  begin
    parsed_address = JSON.parse(row['address'].gsub("'", '"'))
    address = "#{parsed_address['streetAddress']} #{parsed_address['addressLocality']}"
  rescue JSON::ParserError => e
    address = nil
  end

  begin
    parsed_contact = row['contact'].nil? ? nil : JSON.parse(row['contact'].gsub("'", '"'))
  rescue JSON::ParserError => e
    parsed_contact = nil
  end

  begin
    parsed_illustration = row['illustration'].nil? ? nil : JSON.parse(row['illustration'].gsub("'", '"'))
  rescue JSON::ParserError => e
    parsed_illustration = nil
  end

  p row['category_slug']

  category = Category.find_by(name: row['category_slug'])

  attributes = {
    name: row[0],
    address: address,
    visit_duration: row['visit_duration'],
    long: row['long'].gsub(',', '.').to_f,
    lat: row['lat'].gsub(',', '.').to_f,
    category: category,
    shortdescription: row['shortdescription'],
    longdescription: row['longdescription'],
    tel: parsed_contact&.find { |e| e.key?('Téléphone') }&.values&.first,
    mail: parsed_contact&.find { |e| e.key?('Mél') }&.values&.first,
    website: parsed_contact&.find { |e| e.key?('Site web (URL)') }&.values&.first,
    opening: row['opening'],
    tarif: row['tarif'],
    weather_icons: row['weather_icons'],
    illustration: parsed_illustration&.find { |e| e.key?('url') }&.values&.first
  }

  place = Place.create!(attributes)

  puts "Lieu #{place.name} créé"
end


User.create!({nickname: "Vincent", email: "toto+1@free.fr", password: "azerty"})
User.create!({nickname: "Thomas", email: "toto+2@free.fr", password: "azerty"})
User.create!({nickname: "Carine", email: "toto+3@free.fr", password: "azerty"})
User.create!({nickname: "Corentin", email: "toto+4@free.fr", password: "azerty"})

Journey.create!({user: User.first, travel_mode: "walking", duration: 3600, weather_icon: "01d"})

Place.all.each do |place|
  2.times { Visit.create!(place: place, journey: Journey.first) }
end

Visit.all.each do |visit|
  3.times { Review.create!(visit: visit, rating: rand(3..5)) }
end
