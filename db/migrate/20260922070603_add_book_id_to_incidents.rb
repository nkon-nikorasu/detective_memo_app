class AddBookIdToIncidents < ActiveRecord::Migration[7.2]
  def change
    add_reference :incidents, :book, foreign_key: true
  end
end
