class CreateCharacters < ActiveRecord::Migration[7.2]
  def change
    create_table :characters do |t|
      t.timestamps
      t.string :name
      t.integer :gender
      t.integer :age
      t.string :role
      t.text :body
      t.references :incident, foreign_key: true
    end
  end
end
