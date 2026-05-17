class CreateIncidentTimes < ActiveRecord::Migration[7.2]
  def change
    create_table :incident_times do |t|
      t.integer :year
      t.integer :month
      t.integer :date
      t.integer :hour
      t.integer :minuts
      t.integer :second
      t.string :body, null: false
      t.integer :position
      t.references :incident, foreign_key: true
      t.timestamps
    end
  end
end
