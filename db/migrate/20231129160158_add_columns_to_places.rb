class AddColumnsToPlaces < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :tel, :string
    add_column :places, :mail, :string
    add_column :places, :website, :string
  end
end
