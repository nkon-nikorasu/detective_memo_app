class RenameMinutsColumnToIncidentTime < ActiveRecord::Migration[7.2]
  def change
    rename_column :incident_times, :minuts, :minute
  end
end
