class ChangeTrainRoutesTableName < ActiveRecord::Migration[7.1]
  def change
    # Rename the table
    rename_table :train_routes, :schedules
    
    rename_column :bookings, :train_route_id, :schedule_id
    
    add_foreign_key :bookings, :schedules, column: :schedule_id
  end
end
