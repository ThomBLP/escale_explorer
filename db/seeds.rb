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

[Place, Journey, Visit, Review, User].each { |model| model.destroy_all }
Category.destroy_all

Category.create!({name: "spectacles"})
Category.create!({name: "patrimoine"})
Category.create!({name: "restaurants"})
Category.create!({name: "loisirs"})
Category.create!({name: "bars"})
Category.create!({name: "musees"})
puts "categories créées."


filepath = "db/seed3.csv"
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
    illustration: parsed_illustration&.find { |e| e.key?('url') }&.values&.first
  }

  place = Place.create!(attributes)

  puts "Lieu #{place.name} créé"
end

User.create!({nickname: "Vincent", email: "toto+1@free.fr", password: "azerty"})
User.create!({nickname: "Thomas", email: "toto+2@free.fr", password: "azerty"})
User.create!({nickname: "Carine", email: "toto+3@free.fr", password: "azerty"})
User.create!({nickname: "Corentin", email: "toto+4@free.fr", password: "azerty"})
User.create!({nickname: "Lucas", email: "toto+5@free.fr", password: "azerty"})
User.create!({nickname: "Elodie", email: "toto+6@free.fr", password: "azerty"})
User.create!({nickname: "Abdel", email: "toto+7@free.fr", password: "azerty"})
User.create!({nickname: "Jérome", email: "toto+8@free.fr", password: "azerty"})
User.create!({nickname: "Juliette", email: "toto+9@free.fr", password: "azerty"})
User.create!({nickname: "Johanna", email: "toto+10@free.fr", password: "azerty"})
User.create!({nickname: "Paul", email: "toto+11@free.fr", password: "azerty"})
User.create!({nickname: "Eric", email: "toto+12@free.fr", password: "azerty"})
User.create!({nickname: "Malik", email: "toto+13@free.fr", password: "azerty"})
User.create!({nickname: "Aurore", email: "toto+14@free.fr", password: "azerty"})
User.create!({nickname: "Jeanne", email: "toto+15@free.fr", password: "azerty"})
User.create!({nickname: "Patrick", email: "toto+16@free.fr", password: "azerty"})
puts "Utilisateurs créés."


place_eglise = Place.find_by(name: "Eglise de lImmaculée Conception")
journey1 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Malik"))
visit1 = Visit.create!(journey: journey1, place: place_eglise)
Review.create!(visit: visit1, comment: "Super", rating: 5)


journey2 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Johanna"))
visit2 = Visit.create!(journey: journey2, place: place_eglise)
Review.create!(visit: visit2, comment: "Super", rating: 5)

journey3 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Paul"))
visit3 = Visit.create!(journey: journey3, place: place_eglise)
Review.create!(visit: visit3, comment: "Super", rating: 5)


journey4 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Aurore"))
visit4 = Visit.create!(journey: journey4, place: place_eglise)
Review.create!(visit: visit4, comment: "Super", rating: 5)


croisieurope = Place.find_by(name: "CroisiEurope Week-ends")
journey5 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Jérome"))
visit5 = Visit.create!(journey: journey5, place: croisieurope)
Review.create!(visit: visit5, comment: "Super", rating: 5)


journey6 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Juliette"))
visit6 = Visit.create!(journey: journey6, place: croisieurope)
Review.create!(visit: visit6, comment: "Super", rating: 5)

journey7 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Abdel"))
visit7 = Visit.create!(journey: journey7, place: croisieurope)
Review.create!(visit: visit7, comment: "Super", rating: 5)


journey8 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Elodie"))
visit8 = Visit.create!(journey: journey8, place: croisieurope)
Review.create!(visit: visit8, comment: "Super", rating: 5)

pignol_emile_zola = Place.find_by(name: "Pignol Emile Zola")
journey9 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Lucas"))
visit9 = Visit.create!(journey: journey9, place: pignol_emile_zola)
Review.create!(visit: visit9, comment: "Super", rating: 5)


journey10 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Eric"))
visit10 = Visit.create!(journey: journey10, place: pignol_emile_zola)
Review.create!(visit: visit10, comment: "Super", rating: 5)

journey11 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Jeanne"))
visit11 = Visit.create!(journey: journey11, place: pignol_emile_zola)
Review.create!(visit: visit11, comment: "Super", rating: 5)


journey12 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Patrick"))
visit12 = Visit.create!(journey: journey12, place: pignol_emile_zola)
Review.create!(visit: visit12, comment: "Super", rating: 5)
