class AddWeatherActivityToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :weather_activity, :string
  end
end
