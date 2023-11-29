class AddColumnsToPlace < ActiveRecord::Migration[7.1]
  def change
    add_column :places, :shortdescription, :string
    add_column :places, :longdescription, :string
    add_column :places, :contact, :string
    add_column :places, :opening, :string
    add_column :places, :tarif, :string
    add_column :places, :illustration, :string
  end
end
