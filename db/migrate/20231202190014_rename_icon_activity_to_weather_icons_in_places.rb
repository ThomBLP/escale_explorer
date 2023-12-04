class RenameIconActivityToWeatherIconsInPlaces < ActiveRecord::Migration[7.1]
  def change
    rename_column :places, :weather_activity, :weather_icons
  end
end
