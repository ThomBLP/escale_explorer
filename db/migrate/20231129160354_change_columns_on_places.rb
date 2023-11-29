class ChangeColumnsOnPlaces < ActiveRecord::Migration[7.1]
  def change
    remove_column :places, :long
    remove_column :places, :lat
    add_column :places, :long, :float
    add_column :places, :lat, :float
  end
end
