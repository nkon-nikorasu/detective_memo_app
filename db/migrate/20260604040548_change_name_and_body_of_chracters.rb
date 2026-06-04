class ChangeNameAndBodyOfChracters < ActiveRecord::Migration[7.2]
  def change
    change_column :characters, :name, :string, null: false
    change_column :characters, :body, :text, null: false
  end
end
