class ChangeWeatherIconsTypeToJson < ActiveRecord::Migration[7.1]
  def up
    change_column :places, :weather_icons, 'json USING CAST(weather_icons AS json)'
  end
end
