class RemoveColumnsFromPlaces < ActiveRecord::Migration[7.1]
  def change
    remove_column :places, :description, :string
    remove_column :places, :contact, :string
  end
end
