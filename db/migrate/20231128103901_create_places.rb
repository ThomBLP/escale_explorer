class CreatePlaces < ActiveRecord::Migration[7.1]
  def change
    create_table :places do |t|
      t.string :name
      t.string :description
      t.string :address
      t.integer :visit_duration
      t.string :long
      t.string :lat
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
