class ChangeDefaultNullInTrainsAndRenmeBookingsColumnConfirmed < ActiveRecord::Migration[7.1]
  def up
    change_column_default :trains, :working_days, nil
    rename_column         :bookings, :confirmed, :status
    execute("ALTER TABLE bookings ALTER COLUMN status SET DATA TYPE varchar(255)")
  end
  
  def down
    execute("ALTER TABLE bookings ALTER COLUMN status SET DATA TYPE BOOLEAN")
    rename_column :bookings, :status, :confirmed 
  end
end
