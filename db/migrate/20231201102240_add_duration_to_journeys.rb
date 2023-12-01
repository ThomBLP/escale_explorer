class AddDurationToJourneys < ActiveRecord::Migration[7.1]
  def change
    add_column :journeys, :duration, :integer
    remove_column :journeys, :start_time, :date
    remove_column :journeys, :end_time, :date
  end
end
