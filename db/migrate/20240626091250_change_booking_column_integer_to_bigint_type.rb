class ChangeBookingColumnIntegerToBigintType < ActiveRecord::Migration[7.1]
  def up
    change_column :bookings, :pnr_number, :bigint
  end

  def down
    change_column :bookings, :pnr_number, :integer
  end
end
