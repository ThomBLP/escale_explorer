class AddWeatherIconToJourney < ActiveRecord::Migration[7.1]
  def change
    add_column :journeys, :weather_icon, :text
  end
end
