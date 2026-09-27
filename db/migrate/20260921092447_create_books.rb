class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.timestamps
      t.string :google_books_id, null: false, index: { unique: true }
      t.string :title, null: false
      t.string :authors, array: true, default: [], null: false
      t.string :thumbnail_url
    end
  end
end
