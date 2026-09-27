class RemoveBookFromIncidents < ActiveRecord::Migration[7.2]
  def change
    remove_column :incidents, :book, :string
  end
end
