class CreateVisits < ActiveRecord::Migration[7.1]
  def change
    create_table :visits do |t|
      t.references :place, null: false, foreign_key: true
      t.references :journey, null: false, foreign_key: true
      t.timestamps
    end
  end
end
