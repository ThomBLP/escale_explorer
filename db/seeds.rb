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
    illustration: parsed_illustration&.find { |e| e.key?('url') }&.values&.first
  }

  place = Place.create!(attributes)

  puts "Lieu #{place.name} créé"
end

journey = Journey.create!(start_time: DateTime.current, user: User.first)
Visit.create!(journey: journey, place: Place.first)
Visit.create!(journey: journey, place: Place.second)
Visit.create!(journey: journey, place: Place.third)

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




#reviews du jardin guylaine
jardin_guylaine = Place.find_by(name: "Jardin Guylaine Gouzou-Testud")
journey1 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Malik"))
visit1 = Visit.create!(journey: journey1, place: jardin_guylaine)
Review.create!(visit: visit1, comment: "'Une expérience exceptionnelle!'", rating: 5)


journey2 = Journey.create!(start_time: 2.days.ago, user: User.find_by(nickname: "Johanna"))
visit2 = Visit.create!(journey: journey2, place: jardin_guylaine)
Review.create!(visit: visit2, comment: "'Visite mémorable!'", rating: 4)

journey3 = Journey.create!(start_time: 15.days.ago, user: User.find_by(nickname: "Paul"))
visit3 = Visit.create!(journey: journey3, place: jardin_guylaine)
Review.create!(visit: visit3, comment: "'Un trésor caché!'", rating: 5)


journey4 = Journey.create!(start_time: 7.days.ago, user: User.find_by(nickname: "Aurore"))
visit4 = Visit.create!(journey: journey4, place: jardin_guylaine)
Review.create!(visit: visit4, comment: "'L'architecture est à couper le souffle!'", rating: 5)


#reviews du musée de l'imprimerie
musee_imprimerie = Place.find_by(name: "Musée de lImprimerie et de la communication graphique")
journey5 = Journey.create!(start_time: 3.days.ago, user: User.find_by(nickname: "Jérome"))
visit5 = Visit.create!(journey: journey5, place: musee_imprimerie)
Review.create!(visit: visit5, comment: "'Cadre pittoresque et ambiance charmante!'", rating: 4)


journey6 = Journey.create!(start_time: 11.days.ago, user: User.find_by(nickname: "Juliette"))
visit6 = Visit.create!(journey: journey6, place: musee_imprimerie)
Review.create!(visit: visit6, comment: "'Super!'", rating: 5)

journey7 = Journey.create!(start_time: 1.days.ago, user: User.find_by(nickname: "Abdel"))
visit7 = Visit.create!(journey: journey7, place: musee_imprimerie)
Review.create!(visit: visit7, comment: "'Un lieu chargé d'énergie positive.'", rating: 5)


journey8 = Journey.create!(start_time: 9.days.ago, user: User.find_by(nickname: "Elodie"))
visit8 = Visit.create!(journey: journey8, place: musee_imprimerie)
Review.create!(visit: visit8, comment: "'Un site touristique à la hauteur de sa réputation!'", rating: 5)


#reviews du bistrot des Voraces
bistrot_des_voraces = Place.find_by(name: "Bistrot des Voraces")
journey9 = Journey.create!(start_time: 6.days.ago, user: User.find_by(nickname: "Lucas"))
visit9 = Visit.create!(journey: journey9, place: bistrot_des_voraces)
Review.create!(visit: visit9, comment: "'Expérience culinaire exceptionnelle!'", rating: 5)


journey10 = Journey.create!(start_time: 8.days.ago, user: User.find_by(nickname: "Eric"))
visit10 = Visit.create!(journey: journey10, place: bistrot_des_voraces)
Review.create!(visit: visit10, comment: "'Je n'ai pas aimé.'", rating: 2)

journey11 = Journey.create!(start_time: 13.days.ago, user: User.find_by(nickname: "Jeanne"))
visit11 = Visit.create!(journey: journey11, place: bistrot_des_voraces)
Review.create!(visit: visit11, comment: "'Une explosion de saveurs dans chaque bouchée!'", rating: 5)


journey12 = Journey.create!(start_time: 3.days.ago, user: User.find_by(nickname: "Patrick"))
visit12 = Visit.create!(journey: journey12, place: bistrot_des_voraces)
Review.create!(visit: visit12, comment: "'Un menu varié et des recommandations du chef qui valent le détour.'", rating: 5)
