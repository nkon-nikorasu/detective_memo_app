class CreateMemos < ActiveRecord::Migration[7.2]
  def change
    create_table :memos do |t|
      t.timestamps
      t.integer :tag, null: false
      t.text :body, null: false
      t.references :incident, foreign_key: true
    end
  end
end
