class CreateIncidents < ActiveRecord::Migration[7.2]
  def change
    create_table :incidents do |t|
      t.string :book, null: false
      t.string :name
      t.integer :tag
      t.text :body
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
