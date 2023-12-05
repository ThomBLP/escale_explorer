class AddTravelModeToJourney < ActiveRecord::Migration[7.1]
  def change
    add_column :journeys, :travel_mode, :string
  end
end
