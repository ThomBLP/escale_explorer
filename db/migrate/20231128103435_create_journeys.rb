class CreateJourneys < ActiveRecord::Migration[7.1]
  def change
    create_table :journeys do |t|
      t.references :user, null: false, foreign_key: true
      t.date :start_time
      t.date :end_time

      t.timestamps
    end
  end
end
